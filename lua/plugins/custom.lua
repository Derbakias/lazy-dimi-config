local function grep_title(picker)
  local args = picker.opts.args or {}
  local parts = {}
  if vim.list_contains(args, "--case-sensitive") then
    parts[#parts + 1] = "c"
  end
  if vim.list_contains(args, "--word-regexp") then
    parts[#parts + 1] = "w"
  end
  local flags = #parts > 0 and " [" .. table.concat(parts, ",") .. "]" or ""
  local files = {}
  for _, item in ipairs(picker.list.items) do
    if item.file then
      files[item.file] = true
    end
  end
  local n = vim.tbl_count(files)
  picker.title = "Grep" .. flags .. (n > 0 and " in " .. n .. " file" .. (n == 1 and "" or "s") or "")
end

return {
  -- aerial's default branch now requires Neovim 0.12+ (prints a deprecation
  -- error on 0.11). Pin to the maintained nvim-0.11 remove when you upgrade.
  {
    "stevearc/aerial.nvim",
    branch = "nvim-0.11",
  },

  -- Locked colorscheme
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "catppuccin-mocha" },
  },

  -- Completion: don't preselect; Enter inserts newline unless an item is chosen
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<Esc>"] = { "hide", "fallback" },
      },
    },
  },

  -- Free up <C-l> in terminal so it clears the shell
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        actions = {
          explorer_open_all = function(picker)
            local Tree = require("snacks.explorer.tree")
            Tree:walk(Tree:find(picker:cwd()), function(node)
              if node.dir then
                node.open = true
              end
            end, { all = true })
            picker:find()
          end,
        },
        sources = {
          grep = {
            regex = false,
            args = { "--ignore-case" },
            actions = {
              toggle_case_sens = function(picker)
                picker.opts.args = picker.opts.args or {}
                local args = picker.opts.args
                local is_case_sens = vim.list_contains(args, "--case-sensitive")
                for i, arg in ipairs(args) do
                  if arg == "--ignore-case" or arg == "--case-sensitive" then
                    table.remove(args, i)
                    break
                  end
                end
                table.insert(args, is_case_sens and "--ignore-case" or "--case-sensitive")
                grep_title(picker)
                picker:find({ refresh = true })
              end,
              toggle_word = function(picker)
                picker.opts.args = picker.opts.args or {}
                local flag = "--word-regexp"
                local found = false
                for i, arg in ipairs(picker.opts.args) do
                  if arg == flag then
                    table.remove(picker.opts.args, i)
                    found = true
                    break
                  end
                end
                if not found then
                  table.insert(picker.opts.args, flag)
                end
                grep_title(picker)
                picker:find({ refresh = true })
              end,
            },
            formatters = { file = { min_width = 999 } },
            matcher = { sort_empty = true },
            sort = function(a, b)
              local fa = (a.file or ""):match("[^/]*$"):lower()
              local fb = (b.file or ""):match("[^/]*$"):lower()
              if fa ~= fb then
                return fa < fb
              end
              if a.file ~= b.file then
                return (a.file or ""):lower() < (b.file or ""):lower()
              end
              return (a.pos and a.pos[1] or 0) < (b.pos and b.pos[1] or 0)
            end,
            on_change = grep_title,
            win = {
              input = {
                keys = {
                  ["<A-c>"] = { "toggle_case_sens", mode = { "i", "n" }, desc = "Toggle case sensitive" },
                  ["<A-w>"] = { "toggle_word", mode = { "i", "n" }, desc = "Toggle whole word" },
                },
              },
            },
          },
          explorer = {
            win = {
              list = {
                keys = {
                  ["E"] = "explorer_open_all",
                },
              },
            },
          },
        },
        win = {
          input = {
            keys = {
              ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<A-i>"] = { "toggle_ignored", mode = { "i", "n" } },
              ["<A-w>"] = false,
              ["<A-t>"] = { "cycle_win", mode = { "i", "n" } },
              ["<A-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<A-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<A-w>"] = false,
              ["<A-t>"] = { "cycle_win", mode = { "n" } },
            },
          },
          preview = {
            keys = {
              ["<A-w>"] = false,
              ["<A-t>"] = { "cycle_win", mode = { "n" } },
            },
          },
        },
      },
      terminal = {
        auto_insert = false,
        start_insert = false,
        win = {
          keys = {
            nav_l = false,
          },
        },
      },
    },
  },

  -- Navigate staged + unstaged hunks with [h / ]h
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end
        local nav_opts = { target = "all" }
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next", nav_opts)
          end
        end, "Next Hunk")
        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev", nav_opts)
          end
        end, "Prev Hunk")
        map("n", "]H", function()
          gs.nav_hunk("last", nav_opts)
        end, "Last Hunk")
        map("n", "[H", function()
          gs.nav_hunk("first", nav_opts)
        end, "First Hunk")
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
        map("n", "<leader>ghb", function()
          gs.blame_line({ full = true })
        end, "Blame Line")
        map("n", "<leader>ghB", function()
          gs.blame()
        end, "Blame Buffer")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function()
          gs.diffthis("~")
        end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },

  -- Multi-cursor editing
  {
    "mg979/vim-visual-multi",
    branch = "master",
    lazy = false,
    priority = 100,
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<A-d>",
        ["Find Subword Under"] = "<A-d>",
        ["Add Cursor Up"] = "<F20>",
        ["Add Cursor Down"] = "<F21>",
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = "visual_multi_start",
        callback = function()
          vim.keymap.set({ "n", "x" }, "<C-Up>", "<Plug>(VM-Add-Cursor-Up)", { buffer = true })
          vim.keymap.set({ "n", "x" }, "<C-Down>", "<Plug>(VM-Add-Cursor-Down)", { buffer = true })
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "visual_multi_exit",
        callback = function()
          pcall(vim.keymap.del, { "n", "x" }, "<C-Up>", { buffer = true })
          pcall(vim.keymap.del, { "n", "x" }, "<C-Down>", { buffer = true })
        end,
      })
    end,
  },

  -- Bad habit training (arrow keys, repeated hjkl, etc.)
  {
    "m4xshen/hardtime.nvim",
    lazy = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      disable_mouse = false,
      disabled_keys = {
        ["<Up>"] = {},
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
      restricted_keys = {
        ["h"] = {},
        ["j"] = {},
        ["k"] = {},
        ["l"] = {},
      },
    },
  },
  {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {
        heading = {
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          sign = true,
        },
        checkbox = {
          enabled = true,
        },
      },
  },


  -- Seamless C-h/j/k/l navigation between nvim splits and tmux panes
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (nvim/tmux)" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (nvim/tmux)" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (nvim/tmux)" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (nvim/tmux)" },
    },
  },

  -- Vim training game
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },

  -- Typing practice
  {
    "nvzone/typr",
    dependencies = { "nvzone/volt" },
    cmd = { "Typr", "TyprStats" },
    opts = {},
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typr",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          vim.schedule(function()
            vim.bo[bufnr].omnifunc = ""
            -- disable blink.cmp for typr buffers
            vim.b[bufnr].completion = { enabled = false }
          end)
        end,
      })
    end,
  },

  -- Context menu (right-click / <C-t>)
  {
    "nvzone/volt",
    lazy = true,
  },
  {
    "nvzone/menu",
    lazy = false,
    config = function()
      vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
        require("menu.utils").delete_old_menus()
        vim.cmd.exec('"normal! \\<RightMouse>"')
        local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
        local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
        require("menu").open(options, { mouse = true })
      end, { desc = "Open context menu" })

      vim.keymap.set("n", "<C-t>", function()
        require("menu").open("default")
      end, { desc = "Open menu" })
    end,
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (side-by-side)" },
    },
    opts = {
      enhanced_diff_hl = true,
      hooks = {
        -- The Current (OURS) pane's label from update_merge_context below gets
        -- clobbered by diffview's default rev winbar (which shows the branch
        -- name) because that pane's buffer initializes after the label is set.
        -- Re-apply it here, which fires after the window's winbar is assigned so
        -- it wins. Only the Current (stage 2) pane is touched; Incoming/Result
        -- are left to update_merge_context. Stage is read from the buffer name
        -- (".../.git/:2:/path"); the layout window ids are nil on the entry.
        diff_buf_win_enter = function(bufnr, winid, ctx)
          if not ((ctx and ctx.layout_name or ""):match("^diff[34]")) then
            return
          end
          if not vim.api.nvim_buf_get_name(bufnr):match(":2:/") then
            return
          end
          local view = require("diffview.lib").get_current_view()
          local ours = view and view.merge_ctx and view.merge_ctx.ours
          vim.wo[winid].winbar = (" Current %s"):format((ours and ours.hash or ""):sub(1, 10))
        end,
      },
      view = {
        -- VS Code-style merge: OURS | THEIRS on top, the editable result below.
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle file panel" },
          },
          { "n", "<leader>b", false },
          {
            "n",
            "gf",
            function()
              local lib = require("diffview.lib")
              local view = lib.get_current_view()
              if view then
                local file = (view --[[@as any]]):infer_cur_file()
                if file and file.absolute_path then
                  local target_tab = lib.get_prev_non_view_tabpage()
                  if target_tab then
                    vim.api.nvim_set_current_tabpage(target_tab)
                  else
                    vim.cmd("tabnew")
                  end
                  vim.cmd("edit " .. vim.fn.fnameescape(file.absolute_path))
                  vim.cmd("diffoff")
                  pcall(vim.cmd --[[@as function]], "TSBufEnable highlight")
                end
              end
            end,
            { desc = "Open file" },
          },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          {
            "n",
            "<leader>e",
            function()
              require("diffview.actions").toggle_files()
            end,
            { desc = "Toggle file panel" },
          },
          { "n", "<leader>b", false },
          {
            "n",
            "<C-r>",
            function()
              require("diffview.actions").restore_entry()
            end,
            { desc = "Revert file" },
          },
          {
            "n",
            "gf",
            function()
              local lib = require("diffview.lib")
              local view = lib.get_current_view()
              if view then
                local file = (view --[[@as any]]):infer_cur_file()
                if file and file.absolute_path then
                  local target_tab = lib.get_prev_non_view_tabpage()
                  if target_tab then
                    vim.api.nvim_set_current_tabpage(target_tab)
                  else
                    vim.cmd("tabnew")
                  end
                  vim.cmd("edit " .. vim.fn.fnameescape(file.absolute_path))
                  vim.cmd("diffoff")
                  pcall(vim.cmd --[[@as function]], "TSBufEnable highlight")
                end
              end
            end,
            { desc = "Open file" },
          },
        },
      },
    },
    config = function(_, opts)
      -- VS Code-style merge layout. diffview hard-codes OURS on the left,
      -- so we override diff3_mixed's window-creation order to swap the two
      -- top columns => THEIRS (Incoming) left, OURS (Current) right, with
      -- the result buffer full-width below. The conflict-choose keymaps act
      -- on the markers inside the result buffer, not on window position, so
      -- swapping the columns is purely visual and safe.
      local async = require("diffview.async")
      local Window = require("diffview.scene.window").Window
      local Diff3Mixed = require("diffview.scene.layouts.diff_3_mixed").Diff3Mixed
      local api = vim.api
      local await = async.await

      Diff3Mixed.create = async.void(function(self, pivot)
        self:create_pre()
        local curwin

        pivot = pivot or self:find_pivot()
        assert(api.nvim_win_is_valid(pivot), "Layout creation requires a valid window pivot!")

        for _, win in ipairs(self.windows) do
          if win.id ~= pivot then
            win:close(true)
          end
        end

        -- Result (working tree) full-width along the bottom.
        api.nvim_win_call(pivot, function()
          vim.cmd("belowright sp")
          curwin = api.nvim_get_current_win()
          if self.b then self.b:set_id(curwin) else self.b = Window({ id = curwin }) end
        end)

        -- THEIRS created first => ends up on the left.
        api.nvim_win_call(pivot, function()
          vim.cmd("aboveleft vsp")
          curwin = api.nvim_get_current_win()
          if self.c then self.c:set_id(curwin) else self.c = Window({ id = curwin }) end
        end)

        -- OURS created second => ends up on the right.
        api.nvim_win_call(pivot, function()
          vim.cmd("aboveleft vsp")
          curwin = api.nvim_get_current_win()
          if self.a then self.a:set_id(curwin) else self.a = Window({ id = curwin }) end
        end)

        api.nvim_win_close(pivot, true)
        self.windows = { self.a, self.b, self.c }
        await(self:create_post())
      end)

      -- Rename the winbar labels: Incoming / Current / Result.
      local FileEntry = require("diffview.scene.file_entry").FileEntry
      function FileEntry:update_merge_context(ctx)
        ctx = ctx or self.merge_ctx
        if ctx then self.merge_ctx = ctx else return end
        local layout = self.layout
        if layout.a then
          layout.a.file.winbar = (" Current %s"):format((ctx.ours.hash):sub(1, 10))
        end
        if layout.b then
          layout.b.file.winbar = " Result"
        end
        if layout.c then
          layout.c.file.winbar = (" Incoming %s %s"):format(
            (ctx.theirs.hash):sub(1, 10),
            ctx.theirs.ref_names and ("(" .. ctx.theirs.ref_names .. ")") or ""
          )
        end
        if layout.d then
          layout.d.file.winbar = (" Base %s %s"):format(
            (ctx.base.hash):sub(1, 10),
            ctx.base.ref_names and ("(" .. ctx.base.ref_names .. ")") or ""
          )
        end
      end

      require("diffview").setup(opts)
    end,
  },

  -- Show full relative path in statusline; show real search count beyond 99
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_c = {
        {
          "filename",
          path = 1,
          shorting_target = 0,
        },
      }
      -- Remove LazyVim's default clock from lualine_z (since tmux shows datetime).
      opts.sections.lualine_z = {}
      -- Append the search counter to lualine_y so it sits next to progress/location.
      -- Putting it in an empty lualine_z caused the section bg to flash in/out.
      table.insert(opts.sections.lualine_y, {
        function()
          if vim.v.hlsearch == 0 then
            return ""
          end
          local ok, result = pcall(vim.fn.searchcount, { maxcount = 0, recompute = true })
          if not ok or result.total == 0 then
            return ""
          end
          return string.format("[%d/%d]", result.current, result.total)
        end,
      })
    end,
  },

  -- Mason tool installer (LSP servers, formatters, linters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "pyright",
        "eslint-lsp",
        "emmet-language-server",
        "css-lsp",
        "html-lsp",
        "lua-language-server",
        "prettier",
        "black",
        "stylua",
        "shfmt",
        "eslint_d",
        "flake8",
        "debugpy",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- Disable inlay hints globally (LazyVim re-enables on every LSP attach)
  -- Also enable CSS/HTML/Emmet LSPs for CSS property autocomplete + Emmet abbreviations
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        cssls = {},
        html = {},
        emmet_language_server = {
          filetypes = {
            "css",
            "html",
            "javascriptreact",
            "less",
            "sass",
            "scss",
            "typescriptreact",
            "vue",
          },
        },
      },
    },
  },

  -- Force <A-t> = cycle_win (overrides trouble.nvim's trouble_open binding)
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local wins = { "input", "list", "preview" }
      for _, w in ipairs(wins) do
        opts.picker.win[w].keys["<a-t>"] = {
          "cycle_win",
          mode = w == "input" and { "i", "n" } or { "n" },
        }
      end
    end,
  },

  -- Surround text objects. Uses a `gs` prefix instead of mini's default `s`
  -- prefix so it doesn't collide with flash.nvim's `s`/`S` jumps (and avoids the
  -- operator-timing race that bites `ys`/`sa`). `g` isn't an operator, so the
  -- sequence never fires early no matter how slowly you type.
  --   Visual (VSCode-style): select, then press the bracket -> wraps it.
  --   Double/triple via COUNT: viw2{ -> {{word}} , viw3( -> (((word)))
  --   Normal (dot-repeatable): gsaiw)  then `.` repeats on the next word.
  --   Delete:  gsd{char}   Replace: gsr{old}{new}
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      -- "Select a word, press the bracket to wrap it" -- and `.` repeats it.
      -- Each key routes through the NORMAL-mode operator (gsaiw<char>) instead
      -- of a visual surround, because the normal operator is dot-repeatable:
      --   viw {           -> {word}
      --   .               -> {{word}}      (repeat in place to nest/double)
      --   w  .            -> wrap the next word too
      -- Note: this wraps the WORD under the cursor, so it's meant for word
      -- selections. For arbitrary selections / quotes / tags, use `S<char>`
      -- (exact selection, but not dot-repeatable).
      local wrap = {
        ["("] = ")",
        [")"] = ")",
        ["{"] = "}",
        ["}"] = "}",
        ["["] = "]",
        ["]"] = "]",
      }
      for lhs, char in pairs(wrap) do
        vim.keymap.set("x", lhs, "<Esc>gsaiw" .. char, { remap = true, desc = "Wrap word with " .. char .. " (dot-repeatable)" })
      end
      -- Generic "surround exact selection with next char" (quotes, tags, etc).
      vim.keymap.set("x", "S", "gsa", { remap = true, desc = "Surround selection" })
    end,
  },

  -- flash.nvim maps `S` in visual mode (treesitter select), which would shadow
  -- the surround shortcut above. Drop flash's visual `S` only; it keeps `S` in
  -- normal/operator mode for treesitter jumps.
  {
    "folke/flash.nvim",
    keys = {
      { "S", mode = "x", false },
    },
  },
}

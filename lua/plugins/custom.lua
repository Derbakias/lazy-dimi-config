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
  -- Persist colorscheme across sessions
  {
    "LazyVim/LazyVim",
    opts = function()
      local file = vim.fn.stdpath("data") .. "/colorscheme"
      local ok, lines = pcall(vim.fn.readfile, file)
      return { colorscheme = (ok and lines[1]) or "tokyonight" }
    end,
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
              ["<C-f>"] = false,
              ["<C-b>"] = false,
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
    },
  },

  -- Markdown preview
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
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

  -- Auto-pair brackets with Enter expansion ({|} → multiline)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview (side-by-side)" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_vertical" },
        merge_tool = { layout = "diff3_vertical" },
        file_history = { layout = "diff2_vertical" },
      },
      hooks = {
        diff_buf_read = function()
          vim.wo.wrap = true
        end,
        view_opened = function()
          require("markview.commands").Stop()
          require("markview.commands").Disable()
        end,
        view_closed = function()
          require("markview.commands").Start()
        end,
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
      opts.sections.lualine_z = opts.sections.lualine_z or {}
      table.insert(opts.sections.lualine_z, 1, {
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
}

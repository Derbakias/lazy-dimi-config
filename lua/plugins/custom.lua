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
        win = {
          input = {
            keys = {
              ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              ["<A-i>"] = { "toggle_ignored", mode = { "i", "n" } },
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

  -- Code diff viewer
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
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
}

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here

-- Open explorer on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      Snacks.explorer()
    end
  end,
})

-- Define staged gitsigns highlights (dimmed version of normal signs)
-- Most themes don't define GitSignsStaged* so they're invisible
local function setup_gitsigns_staged_hl()
  local function dim(color, factor)
    local r = math.floor(math.floor(color / 0x10000) * factor)
    local g = math.floor(math.floor(color % 0x10000 / 0x100) * factor)
    local b = math.floor(color % 0x100 * factor)
    return r * 0x10000 + g * 0x100 + b
  end
  local map = {
    GitSignsStagedAdd = "GitSignsAdd",
    GitSignsStagedChange = "GitSignsChange",
    GitSignsStagedDelete = "GitSignsDelete",
    GitSignsStagedTopdelete = "GitSignsDelete",
    GitSignsStagedChangedelete = "GitSignsChange",
  }
  for staged, base in pairs(map) do
    local hl = vim.api.nvim_get_hl(0, { name = base })
    if hl.fg then
      vim.api.nvim_set_hl(0, staged, { fg = dim(hl.fg, 0.6) })
    end
  end
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = setup_gitsigns_staged_hl })
vim.api.nvim_create_autocmd("VimEnter", { callback = vim.schedule_wrap(setup_gitsigns_staged_hl) })

-- Remove :IncRename from command history so it doesn't replay on :<Up>
vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    vim.schedule(function()
      vim.fn.histdel(":", "^IncRename")
    end)
  end,
})

-- Save colorscheme on change so it persists across sessions
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.fn.writefile({ vim.g.colors_name }, vim.fn.stdpath("data") .. "/colorscheme")
  end,
})
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

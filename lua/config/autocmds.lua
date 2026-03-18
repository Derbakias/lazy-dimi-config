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

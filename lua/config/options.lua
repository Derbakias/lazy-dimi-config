-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 999 -- keep cursor centered vertically
vim.opt.shortmess:append("Ss") -- S: hide capped native count (lualine shows real count); s: hide wrap messages
vim.opt.wrap = true -- wrap long lines within the window

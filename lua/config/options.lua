-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 999 -- keep cursor centered vertically
vim.opt.shortmess:append("Ss") -- S: hide capped native count (lualine shows real count); s: hide wrap messages
vim.opt.wrap = true -- wrap long lines within the window
-- inlay hints disabled via nvim-lspconfig opts (see plugins/custom.lua)
vim.g.lazyvim_prettier_needs_config = false -- run prettier even without a project config
vim.g.autoformat = false -- disable autoformat on save by default; toggle with <leader>uf
vim.g.root_spec = { { ".git" }, "lsp", "cwd" } -- prefer git root over LSP workspace for pickers

-- Clipboard over SSH: there's no X/Wayland display on remote hosts, so xclip/wl-copy
-- silently fail. Use the OSC 52 provider so yanks reach the *local* terminal's
-- clipboard (tmux forwards OSC 52 — see tmux.conf set-clipboard). Paste reads the
-- local register so in-nvim `"+p` works without hanging on a terminal query.
local osc52 = require("vim.ui.clipboard.osc52")
local function reg_paste()
  return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
end
vim.g.clipboard = {
  name = "osc52",
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = reg_paste, ["*"] = reg_paste },
}

-- LazyVim sets clipboard="" under SSH (lazyvim/config/options.lua:57), so a plain
-- `yy` never reaches the + register and the OSC 52 provider above never fires.
-- Fighting that startup-ordering is brittle, so mirror every real yank into + at
-- runtime instead — ordering-independent and fires on each yank.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local ev = vim.v.event
    -- Only mirror genuine yanks to the default/+ register (skip deletes and named regs).
    if ev.operator == "y" and (ev.regname == "" or ev.regname == "+") then
      vim.fn.setreg("+", ev.regcontents, ev.regtype)
    end
  end,
})

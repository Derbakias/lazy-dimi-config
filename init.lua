-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Open explorer alongside the dashboard on startup. Registered here (not in
-- lua/config/autocmds.lua) so it runs before VimEnter — autocmds.lua loads on
-- VeryLazy, which is too late.
vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  once = true,
  callback = function()
    vim.schedule(function()
      if #Snacks.picker.get({ source = "explorer" }) == 0 then
        Snacks.explorer.open()
        vim.cmd("wincmd p") -- keep focus on the dashboard
      end
    end)
  end,
})

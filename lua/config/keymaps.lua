-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "5j", { desc = "Scroll down" })
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "5k", { desc = "Scroll up" })
vim.keymap.set("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>z", function()
  Snacks.toggle.new({
    id = "zoom",
    name = "Zoom Mode",
    notify = false,
    get = function() return Snacks.zen.win and Snacks.zen.win:valid() or false end,
    set = function(state)
      if state then Snacks.zen.zoom()
      elseif Snacks.zen.win then Snacks.zen.win:close() end
    end,
  }):toggle()
end, { desc = "Toggle zoom window" })
vim.keymap.set("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<C-n>", function() Snacks.explorer() end, { desc = "Toggle explorer" })
vim.keymap.set("n", "<C-e>", function() Snacks.explorer() end, { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ft", function()
  if vim.bo.buftype == "terminal" then
    vim.cmd("vsplit | terminal")
  else
    vim.cmd("belowright split | terminal")
  end
end, { desc = "New Terminal" })
vim.keymap.set("n", "<leader>fw", function()
  local wins = vim.api.nvim_list_wins()
  local items = {}
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)
    local bt = vim.bo[buf].buftype
    if bt == "terminal" then
      name = "Terminal"
    elseif name == "" then
      name = "[No Name]"
    else
      name = vim.fn.fnamemodify(name, ":~:.")
    end
    table.insert(items, { win = win, label = name })
  end
  vim.ui.select(items, {
    prompt = "Focus window",
    format_item = function(item) return item.label end,
  }, function(item)
    if item then vim.api.nvim_set_current_win(item.win) end
  end)
end, { desc = "Focus Window" })

vim.keymap.set({ "n", "v", "x" }, ";", ":", { desc = "Enter command mode" })
vim.keymap.set({ "n", "v", "x" }, "<leader>;", ";", { desc = "Repeat last f/F/t/T" })

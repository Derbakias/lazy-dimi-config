-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(ev)
    local ft = vim.bo[ev.buf].filetype or ""
    if vim.bo[ev.buf].buftype == "" and not ft:match("^snacks_") then
      vim.keymap.set({ "n", "v", "x" }, "<C-d>", "5j", { desc = "Scroll down", buffer = ev.buf })
      vim.keymap.set({ "n", "v", "x" }, "<C-u>", "5k", { desc = "Scroll up", buffer = ev.buf })
    end
  end,
})

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

vim.keymap.set({ "n", "v", "x" }, "<A-j>", "<C-f>", { desc = "Scroll page down" })
vim.keymap.set({ "n", "v", "x" }, "<A-k>", "<C-b>", { desc = "Scroll page up" })

-- Move lines (Alt+Shift+J/K), replacing the LazyVim defaults overridden above
vim.keymap.set("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
vim.keymap.set("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<leader>fG", function()
  local function split(s)
    local t = {}
    for part in s:gmatch("[^,]+") do t[#t + 1] = vim.trim(part) end
    return t
  end
  vim.ui.input({ prompt = "Include (e.g. src, *.ts, lib/*.py — empty = all): " }, function(inc_input)
    if inc_input == nil then return end
    vim.ui.input({ prompt = "Exclude (e.g. dist, *.test.ts — empty = none): " }, function(excl_input)
      if excl_input == nil then return end
      local opts = { dirs = {}, glob = {} }
      for _, part in ipairs(split(inc_input)) do
        if part:match("%.[a-zA-Z]+$") then
          -- file glob: *.ts, lib/*.py
          opts.glob[#opts.glob + 1] = part
        elseif part:match("[*?]") then
          -- dir wildcard: sortino-*, my-* → expand to real dirs
          for _, d in ipairs(vim.fn.glob(part, false, true)) do
            if vim.fn.isdirectory(d) == 1 then
              opts.dirs[#opts.dirs + 1] = d
            end
          end
        else
          -- plain dir: src, lib
          opts.dirs[#opts.dirs + 1] = part
        end
      end
      if #opts.dirs == 0 then opts.dirs = nil end
      if #opts.glob == 0 then opts.glob = nil end
      if excl_input ~= "" then opts.exclude = split(excl_input) end
      Snacks.picker.grep(opts)
    end)
  end)
end, { desc = "Grep with includes/excludes" })

vim.keymap.set({ "n", "v", "x" }, ";", ":", { desc = "Enter command mode" })
vim.keymap.set({ "n", "v", "x" }, "<leader>;", ";", { desc = "Repeat last f/F/t/T" })

-- REST client for Neovim. Use `.http` or `.rest` files.
return {
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
      { "<leader>Rr", desc = "Replay last request" },
      { "<leader>Ri", desc = "Inspect current request" },
      { "<leader>Rc", desc = "Copy as cURL" },
      { "<leader>RS", desc = "Show stats" },
      { "<leader>Rt", desc = "Toggle view (body/headers)" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
}

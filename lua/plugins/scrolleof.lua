return {
  {
    "Aasim-A/scrollEOF.nvim",
    event = { "CursorMoved", "WinScrolled" },
    opts = {},
    config = function(_, opts)
      local scrollEOF = require("scrollEOF")
      scrollEOF.setup(opts)
      setmetatable(scrollEOF.opts.disabled_filetypes, {
        __index = function()
          return vim.bo.buftype ~= ""
        end,
      })
    end,
  },
}

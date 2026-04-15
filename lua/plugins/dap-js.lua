return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")

    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data")
              .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end

    for _, lang in ipairs({ "javascript", "typescript" }) do
      dap.configurations[lang] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- TypeScript-only: run .ts directly via tsx (handles source maps automatically)
    table.insert(dap.configurations.typescript, 1, {
      type = "pwa-node",
      request = "launch",
      name = "Launch current TS file (tsx)",
      runtimeExecutable = "npx",
      runtimeArgs = { "tsx" },
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
    })
  end,
}

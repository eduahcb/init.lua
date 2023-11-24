
local dap = require('dap')
local dapui = require('dapui')
local dap_ruby = require('dap-ruby')
local dap_virutal_text = require("nvim-dap-virtual-text")

-- Styling
vim.fn.sign_define('DapBreakpoint',{ text ='🚩', texthl ='', linehl ='', numhl ='' })
vim.fn.sign_define('DapStopped',{ text ='💧', texthl ='', linehl ='', numhl =''})

-- Setup
dap_ruby.setup()
dapui.setup()
dap_virutal_text.setup()

dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executable = {
    command = "js-debug-adapter",
  }
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "node"
    }
  }
end

-- MAPS 
vim.keymap.set("n", "<leader>bp", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>ds", "<cmd>lua require('dap').continue()<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local dap = require("dap")
local dap_utils = require("dap.utils")
local dap_configuration = require("dap-configuration")
local mason_registry = require("mason-registry")
local codelldb = mason_registry.get_package("codelldb")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb:get_install_path(),
        args = { "--port", "${port}" },
    }
}

dap.configurations.cpp = {
    {
        name = "Launch File",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    }
}
dap.confgurations.c = dap.confgurations.cpp

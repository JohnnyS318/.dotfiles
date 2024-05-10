return {
    {
        "rcarriga/nvim-dap-ui",
        event = "VeryLazy",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function(_, opts)
            local dap = require("dap")
            require("dapui").setup(opts)
            local dapui = require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            automatic_setup = true,
            handlers = {},
        },
    },
    {
        "mfussenegger/nvim-dap",
        keys = require("config.dap-keymaps").dap,
        config = function()
            vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
            vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
            vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

            vim.fn.sign_define(
                "DapBreakpoint",
                { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
            )
            vim.fn.sign_define(
                "DapLogPoint",
                { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
            )
            vim.fn.sign_define(
                "DapStopped",
                { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
            )
        end,
    },
    { "nvim-neotest/nvim-nio" },
}

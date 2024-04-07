return {
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup()
            -- vim.keymap.set("n")
        end,
        cmd = "Neogen",
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        opts = {
            pre_hook = function()
                require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
            end,
        },
    },
}

return {
    {
        "b0o/SchemaStore.nvim",
    },
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependecies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            { "<leader>cy", "<CMD>Telescope yaml_schema<CR>", desc = "Select YAML Schema" },
        },
        config = function(_, opts)
            require("telescope").load_extension("yaml_schema")
        end,
    },
}

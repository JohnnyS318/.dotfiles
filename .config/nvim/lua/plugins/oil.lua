return {
    --[[ {
        "stevearc/oil.nvim",
        cmd = "Oil",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = true,
            delete_to_trash = true,
            keymaps = {
                ["<Esc>"] = "actions.close",
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open()
                end,
                desc = "Open parent directory",
            },
        },
    }, ]]
}

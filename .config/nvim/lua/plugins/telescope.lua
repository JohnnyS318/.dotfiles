-- Telescope fuzzy finding (all the things)
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
            "BurntSushi/ripgrep",
        },
        config = function()
            require("telescope").setup {}

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")

            local builtin = require("telescope.builtin")

            vim.keymap.set(
                "n",
                "<leader>so",
                builtin.oldfiles,
                { silent = true, desc = "Search Recently Open (Telescope)" }
            )
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { silent = true, desc = "Find Files (Telescope)" })
            vim.keymap.set(
                "n",
                "<leader><space>",
                builtin.find_files,
                { silent = true, desc = "Find Files (Telescope)" }
            )
            vim.keymap.set(
                "n",
                "<leader>sw",
                builtin.grep_string,
                { silent = true, desc = "Find Current Word (Telescope)" }
            )
            vim.keymap.set("n", "<leader>sg", builtin.live_grep, { silent = true, desc = "Find Live Grep (Telescope)" })
        end,
    },
}

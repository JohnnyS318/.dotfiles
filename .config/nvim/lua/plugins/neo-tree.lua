-- neo-tree

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup {
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                }
            end,
        },
    },
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute { toggle = true }
            end,
            desc = "Toggle NeoTree",
        },
        {
            "<leader>e",
            "<leader>fe",
            desc = "Toggle NeoTree",
            remap = true,
        },
    },
    opts = {
        sources = { "filesystem", "buffers", "git_status" },
        filesystem = {
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = {
                    "node_modules",
                    ".git",
                },
            },
            find_command = "fd",
            find_args = {
                fd = {
                    "--exclude",
                    ".git",
                    "--exclude",
                    "node_modules",
                },
            },
        },
    },
    config = function(_, opts)
        require("neo-tree").setup(opts)
    end,
}

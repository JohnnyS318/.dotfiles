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
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension("fzf"))

            local builtin = require("telescope.builtin")

            function vim.find_files_from_project_git_root()
                local function is_git_repo()
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    return vim.v.shell_error == 0
                end
                local function get_git_root()
                    local dot_git_path = vim.fn.finddir(".git", ".;")
                    return vim.fn.fnamemodify(dot_git_path, ":h")
                end
                local lopts = {
                    hidden = true,
                }
                if is_git_repo() then
                    lopts = {
                        cwd = get_git_root(),
                        hidden = true,
                    }
                end
                require("telescope.builtin").find_files(lopts)
            end

            vim.keymap.set(
                "n",
                "<leader>fo",
                builtin.oldfiles,
                { silent = true, desc = "Search Recently Open (Telescope)" }
            )
            vim.keymap.set("n", "<leader>ff", builtin.git_files, { silent = true, desc = "Find Files (Telescope)" })
            vim.keymap.set(
                "n",
                "<leader><space>",
                builtin.find_files,
                { silent = true, desc = "Find Files (Telescope)" }
            )
            vim.keymap.set(
                "n",
                "<leader>fw",
                builtin.grep_string,
                { silent = true, desc = "Find Current Word (Telescope)" }
            )
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { silent = true, desc = "Find Buffers (Telescope)" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { silent = true, desc = "Find Live Grep (Telescope)" })
            vim.keymap.set(
                "n",
                "<leader>fm",
                builtin.keymaps,
                { silent = false, desc = "Find / Search Keymaps (Telescope)" }
            )
            vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume Last Picker" })
        end,
    },
}

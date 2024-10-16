--return {}

-- lint configuration
-- either guard.nvim (@see guard.lua) or nvim-lint

return {
    {
        -- I use nvim-lint for now but maybe tranfer to only diagnostic-lsp later down the line
        "mfussenegger/nvim-lint",
        config = function(_, opts)
            require("lint").linters_by_ft = {
                --markdown = { "vale" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                javascriptreact = { "eslint_d" },
                typescriptreact = { "eslint_d" },
                -- javascript = { "biomejs" },
                -- typescript = { "biomejs" },
                -- javascriptreact = { "biomejs" },
                -- typescriptreact = { "biomejs" },
                -- svelte = { "biome" },
                svelte = { "eslint_d" },
                go = { "golangcilint" },
                cmake = { "cmakelint" },
                sql = { "sqlfluff" },
                starlark = { "buildifier" },
                bzl = { "buildifier" },
                --cpp = { "cpplint" },
            }


            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    require("lint").try_lint()

                    -- You can call `try_lint` with a linter name or a list of names to always
                    -- run specific linters, independent of the `linters_by_ft` configuration
                    -- require("lint").try_lint("cspell")
                end,
            })

            vim.api.nvim_buf_create_user_command(0, "LintRunning", function()
                require("lint").get_running()
            end, { desc = "See running nvim-lint linters" })
        end,
    },
}

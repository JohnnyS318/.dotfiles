return {
    {
        -- I use nvim-lint for now but maybe tranfer to only diagnostic-lsp later down the line
        "mfussenegger/nvim-lint",
        config = function(_, opts)
            require("lint").linters_by_ft = {
                --markdown = { "vale" },
                -- javascript = { "eslint_d" },
                -- typescript = { "eslint_d" },
                -- javascriptreact = { "eslint_d" },
                -- typescriptreact = { "eslint_d" },
                javascript = { "biomejs" },
                typescript = { "biomejs" },
                javascriptreact = { "biomejs" },
                typescriptreact = { "biomejs" },
                svelte = { "biome" },
                go = { "golangcilint" },
                cmake = { "cmakelint" },
                sql = { "sqlfluff" },
            }

            local function debounce(ms, fn)
                local timer = vim.uv.new_timer()
                return function(...)
                    local argv = { ... }
                    timer:start(ms, 0, function()
                        timer:stop()
                        vim.schedule_wrap(fn)(unpack(argv))
                    end)
                end
            end

            -- the events can possibly (especially InsertLeaver) result in problems due to some linters
            -- being unable to lint --stdio inputs and just written files
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
                group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
                callback = debounce(100, function()
                    require("lint").try_lint()
                end),
            })

            vim.api.nvim_buf_create_user_command(0, "LintRunning", function()
                require("lint").get_running()
            end, { desc = "See running nvim-lint linters" })
        end,
    },
}

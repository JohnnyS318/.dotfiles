--return {}

-- formatting & linter config

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format { async = true, lsp_fallback = true }
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- Everything in opts will be passed to setup()
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            typescript = { "eslint_d", { "prettierd", "prettier" } },
            typescriptreact = { "eslint_d", { "eslint_d", "prettierd", "prettier" } },
            javascript = { "eslint_d", { "prettierd", "prettier" } },
            javascriptreact = { "eslint_d", { "prettierd", "prettier" } },
            svelte = { "eslint_d", { "prettierd", "prettier" } },
            json = { { "jq", "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            mdx = { { "prettierd", "prettier" } },
            go = { "goimports", "gofumpt" },
            cmake = { "cmake_format" },
            -- clang-format is build into the lsp by default
            c = { "clang-format" },
            cpp = { "clang-format" },
            haskell = { "fourmolu" },
            sql = { "sql-formatter" },
        },
        -- Set up format-on-save
        -- format_on_save = { timeout_ms = 500, lsp_fallback = true },

        format_on_save = function(buffer)
            local ignore_filetypes = { "markdown" }
            if vim.tbl_contains(ignore_filetypes, vim.bo[buffer].filetype) then
                return
            end
            if vim.g.disable_autoformat or vim.b[buffer].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,

        -- Customize formatters
        --   formatters = {
        --     shfmt = {
        --       prepend_args = { "-i", "2" },
        --     },
        --   },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    config = function(_, opts)
        require("conform").setup(opts)

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end,
}

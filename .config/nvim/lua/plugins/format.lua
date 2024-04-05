--return {}

-- formatting & linter config

return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
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
            json = { { "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            mdx = { { "prettierd", "prettier" } },
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
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
}

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
            --[[ typescript = { "eslint_d", { "prettierd", "prettier" } },
            typescriptreact = { "eslint_d", { "eslint_d", "prettierd", "prettier" } },
            javascript = { "eslint_d", { "prettierd", "prettier" } },
            javascriptreact = { "eslint_d", { "prettierd", "prettier" } },
            svelte = { "eslint_d", { "prettierd", "prettier" } }, ]]
            typescript = { "biome" },
            typescriptreact = { "biome" },
            javascript = { "biome" },
            javascriptreact = { "biome" },
            svelte = { "biome" },
            json = { { "jq", "prettierd", "prettier" } },
            html = { { "prettierd", "prettier" } },
            css = { { "prettierd", "prettier" } },
            markdown = { { "prettierd", "prettier" } },
            mdx = { { "prettierd", "prettier" } },
            go = { "goimports", "gofumpt" },
            cmake = { "cmake_format" },
            -- clang-format is build into the lsp by default
            -- c = { "clang-format" },
            -- cpp = { "clang-format" },
            haskell = { "fourmolu" },
            sql = { "sql-formatter" },
            starlark = { "buildifier" },
            bzl = { "buildifier" },
            -- rust = { ""}
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
    --[[ init = function()
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
    end, ]]

    config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = vim.tbl_keys(require("conform").formatters_by_ft),
            group = vim.api.nvim_create_augroup("conform_formatexpr", { clear = true }),
            callback = function()
                vim.opt_local.formatexpr = 'v:lua.require("conform").formatexpr()'
            end,
        })
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        require("conform").setup(opts)
        vim.g.auto_conform_on_save = true
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                if vim.g.auto_conform_on_save then
                    require("conform").format { bufnr = args.buf, timeout_ms = nil }
                end
            end,
        })
        vim.api.nvim_create_user_command("ConformToggleOnSave", function()
            vim.g.auto_conform_on_save = not vim.g.auto_conform_on_save
            vim.notify("Auto-Conform on save: " .. (vim.g.auto_conform_on_save and "Enabled" or "Disabled"))
        end, {})
    end,
}

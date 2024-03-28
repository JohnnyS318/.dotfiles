return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            {
                "j-hui/fidget.nvim",
                event = "LspAttach",
            },
            "RRethy/vim-illuminate",
            "hrsh7th/cmp-nvim-lsp",
            --"ms-jpq/coq_nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                },
            }

            require("fidget").setup()

            -- ##### Diagnositcs #####
            -- Set up cool signs for diagnostics
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            -- Diagnostic config
            local config = {
                virtual_text = false,
                signs = {
                    active = signs,
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            }
            vim.diagnostic.config(config)
            -- what happens at LSPAttach event... keymaps are set in configs
            local on_attach = function(client, buffer)
                require("config.lsp-keymaps").on_attach(client, buffer)

                -- setup lsp format command used by <leader>cF binding
                vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
                    vim.lsp.buf.format()
                end, { desc = "Format current buffer with LSP formatter" })
                require("illuminate").on_attach(client)
            end

            -- broadcast additional completion capabilities to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require("coq").lsp_ensure_capabilities(capabilities) -- USE IF using coq
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- USE IF using cmp

            -- ##### SETUP #####

            -- LUA
            require("lspconfig").lua_ls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            }
        end,
    },
}

return {
    {
        "folke/neodev.nvim",
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup {}
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons", -- optional
        },
    },
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
            -- Javascript
            require("lspconfig").tsserver.setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }

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

            -- diagnostics

            -- Setup diagnostics formaters and linters for non LSP provided files
            require("lspconfig").diagnosticls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "diagnostic-languageserver", "--stdio" },
                filetypes = {
                    "lua",
                    "sh",
                    "markdown",
                    "json",
                    "yaml",
                    "toml",
                },
                init_options = {
                    linters = {
                        shellcheck = {
                            command = "shellcheck",
                            debounce = 100,
                            args = { "--format", "json", "-" },
                            sourceName = "shellcheck",
                            parseJson = {
                                line = "line",
                                column = "column",
                                endLine = "endLine",
                                endColumn = "endColumn",
                                message = "${message} [${code}]",
                                security = "level",
                            },
                            securities = {
                                error = "error",
                                warning = "warning",
                                info = "info",
                                style = "hint",
                            },
                        },
                        markdownlint = {
                            command = "markdownlint",
                            isStderr = true,
                            debounce = 100,
                            args = { "--stdin" },
                            offsetLine = 0,
                            offsetColumn = 0,
                            sourceName = "markdownlint",
                            formatLines = 1,
                            formatPattern = {
                                "^.*?:\\s?(\\d+)(:(\\d+)?)?\\s(MD\\d{3}\\/[A-Za-z0-9-/]+)\\s(.*)$",
                                {
                                    line = 1,
                                    column = 3,
                                    message = { 4 },
                                },
                            },
                        },
                    },
                    filetypes = {
                        sh = "shellcheck",
                        markdown = "markdownlint",
                    },
                    formatters = {
                        shfmt = {
                            command = "shfmt",
                            args = { "-i", "2", "-bn", "-ci", "-sr" },
                        },
                        prettier = {
                            command = "prettier",
                            args = { "--stdin-filepath", "%filepath" },
                        },
                    },
                    formatFiletypes = {
                        sh = "shfmt",
                        json = "prettier",
                        yaml = "prettier",
                        toml = "prettier",
                        markdown = "prettier",
                        lua = "prettier",
                    },
                },
            }
        end,
    },
}

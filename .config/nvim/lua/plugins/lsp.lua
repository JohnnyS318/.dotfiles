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
            "hrsh7th/cmp-nvim-lsp",
            "nvimdev/lspsaga.nvim",
            "someone-stole-my-name/yaml-companion.nvim",
            --"ms-jpq/coq_nvim",
        },
        config = function()
            ---Get opts table from the lazy plugin definition
            ---@param name string
            ---@return table
            local getPluginOptions = function(name)
                local plugin = require("lazy.core.config").plugins[name]
                if not plugin then
                    return {}
                end
                local Plugin = require("lazy.core.plugin")
                return Plugin.values(plugin, "opts", false)
            end
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
                virtual_text = true,
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

            local base_on_attach = function(client, buffer) end

            -- what happens at LSPAttach event... keymaps are set in configs
            local on_attach = function(client, buffer)
                require("config.lsp-keymaps").on_attach(client, buffer)

                -- setup lsp format command used by <leader>cF binding
                vim.api.nvim_buf_create_user_command(buffer, "Format", function(_)
                    vim.lsp.buf.format()
                end, { desc = "Format current buffer with LSP formatter" })
            end

            -- broadcast additional completion capabilities to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            -- capabilities = require("coq").lsp_ensure_capabilities(capabilities) -- USE IF using coq
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- USE IF using cmp

            -- ##### SETUP #####
            local lspconfig = require("lspconfig")

            -- ON_ATTACH autocommand
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(event)
                    on_attach({}, event.buf)
                end,
            })

            -- Javascript/Typescript(react)

            local tsserverconfig = require("plugins.lsp.tsserver")
            lspconfig.tsserver.setup {
                on_attach = tsserverconfig.on_tsserver_attach(base_on_attach),
                capabilities = capabilities,
                commands = {
                    OrganizeImports = {
                        tsserverconfig.organize_ts_imports,
                        description = "Organize Imports",
                    },
                },
            }

            lspconfig.tailwindcss.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
            }

            -- SVELTE
            lspconfig.svelte.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
            }

            --HTML
            lspconfig.html.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
                settings = {
                    html = {
                        format = {
                            templating = true,
                            wrapAttributes = "auto",
                        },
                        hover = {
                            documentation = true,
                            references = true,
                        },
                    },
                },
            }

            -- GO
            lspconfig.gopls.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
            }

            -- HASKELL
            -- Do not configure @see plugins/langs/haskell.lua

            -- RUST
            -- Do not configure @see plugins/langs/rust.lua

            -- C/C++
            lspconfig.clangd.setup {
                on_attach = require("plugins.lsp.clangd").on_clangd_attach(base_on_attach),
                capabilities = capabilities,
                filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja"
                    )(fname) or require("lspconfig.util").root_pattern(
                        "compile_commands.json",
                        "compile_flags.txt"
                    )(fname) or require("lspconfig.util").find_git_ancestor(fname)
                end,
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
            }

            lspconfig.neocmake.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
            }
            -- TYPST
            lspconfig.typst_lsp.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
            }

            -- YAML
            lspconfig.yamlls.setup(require("plugins.lsp.yaml").setup(base_on_attach, capabilities))
            -- JSON
            lspconfig.jsonls.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        format = {
                            enable = true,
                        },
                        validate = {
                            enable = true,
                        },
                    },
                },
            }
            --HELM
            lspconfig.helm_ls.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
                logLevel = "info",
                valuesFiles = {
                    mainValuesFile = "values.yaml",
                    lintOverlayValuesFile = "values.lint.yaml",
                    additionalValuesFilesGlobPattern = "values*.yaml",
                },
                yamlls = {
                    enabled = true,
                    diagnosticsLimit = 50,
                    showDiagnosticsDirectly = false,
                    path = "yaml-language-server",
                    config = {
                        schemas = {
                            kubernetes = "templates/**",
                        },
                        completion = true,
                        hover = true,
                        -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
                    },
                },
            }

            -- LUA
            lspconfig.lua_ls.setup {
                on_attach = base_on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                            },
                            maxPreload = 100000,
                            preloadFileSize = 10000,
                        },
                    },
                },
            }

            -- diagnostics

            -- Setup diagnostics formaters and linters for non LSP provided files
            lspconfig.diagnosticls.setup {
                on_attach = base_on_attach,
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

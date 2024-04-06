-- return {}
-- Autocompletion
return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function(_, opts)
            vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            local kind_icons = {
                Text = "",
                Method = "m",
                Function = "",
                Constructor = "",
                Field = "",
                Variable = "",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "",
                Event = "",
                Operator = "",
                TypeParameter = "",
            }
            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert {
                    ["<C-k>"] = cmp.mapping.select_prev_item(),
                    ["<C-j>"] = cmp.mapping.select_next_item(),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    -- ["<C-space>"] = cmp.open_docs(),
                    ["<C-space>"] = cmp.mapping.complete(), -- open completion on ctrl+space
                    ["<CR>"] = cmp.mapping.confirm {
                        -- behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- that way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        -- Kind icons
                        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
                completion = {
                    -- keyword_length  1,
                    -- keyword_pattern = ".*",
                },
                experimental = {
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    },
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            }
        end,
    },
}
-- return {
--     {
--         "hrsh7th/nvim-cmp",
--         event = "InsertEnter",
--         version = false,
--         depedencies = {
--             "hrsh7th/cmp-nvim-lsp",
--             "hrsh7th/cmp-nvim-lua",
--             "hrsh7th/cmp-buffer",
--             "hrsh7th/cmp-path",
--             "hrsh7th/cmp-cmdline",
--             "saadparwaiz1/cmp_luasnip",
--             "L3MON4D3/LuaSnip",
--             "rafamadriz/friendly-snippets",
--         },
--         config = function()
--             vim.opt.completeopt = { "menu", "menuone", "noselect" }
--             vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
--             local has_words_before = function()
--                 unpack = unpack or table.unpack
--                 local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--                 return col ~= 0
--                     and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--             end
--             local cmp = require("cmp")
--             local luasnip = require("luasnip")
--
--             -- add snippets
--             require("luasnip/loaders/from_vscode").lazy_load()
--
--             vim.print("Called")
--
--             -- setup cmp
--             cmp.setup {
--                 snippet = {
--                     expand = function(args)
--                         luasnip.lsp_expand(args.body)
--                     end,
--                 },
--                 experimental = {
--                     ghost_text = {
--                         hl_group = "CmpGhostText",
--                     },
--                 },
--                 window = {
--                     documentation = cmp.config.window.bordered(),
--                 },
--                 mappings = {
--                     ["<C-k>"] = cmp.select_next_item(),
--                     -- ["<C-p>"] = cmp.mapping.select_prev_item(),
--                     -- ["<C-n>"] = cmp.mapping.select_next_item(),
--                     -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--                     -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                     -- ["<C-e>"] = cmp.mapping.abort(),
--                     -- ["<C-CR>"] = cmp.mapping.confirm { select = true },
--
--                     -- TODO: rethink
--
--                     ["<Tab>"] = cmp.mapping(function(fallback)
--                         if cmp.visible() then
--                             cmp.select_next_item()
--                         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--                         -- that way you will only jump inside the snippet region
--                         elseif luasnip.expand_or_jumpable() then
--                             luasnip.expand_or_jump()
--                         elseif has_words_before() then
--                             cmp.complete()
--                         else
--                             fallback()
--                         end
--                     end, { "i", "s" }),
--
--                     ["<S-Tab>"] = cmp.mapping(function(fallback)
--                         if cmp.visible() then
--                             cmp.select_prev_item()
--                         elseif luasnip.jumpable(-1) then
--                             luasnip.jump(-1)
--                         else
--                             fallback()
--                         end
--                     end, { "i", "s" }),
--                 },
--                 sources = cmp.config.sources {
--                     { name = "nvim_lsp" },
--                     { name = "luasnip" },
--                     { name = "buffer" },
--                     { name = "path" },
--                 },
--             }
--         end,
--     },
-- }

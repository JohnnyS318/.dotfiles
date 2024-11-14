-- return {}
-- Autocompletion
return {
	{
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"mikavilpas/blink-ripgrep.nvim",
		},

		-- use a release tag to download pre-built binaries
		--version = 'v0.*',
		-- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		build = 'cargo +nightly build --release --target-dir=target',
		-- On musl libc based systems you need to add this flag
		-- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',

		opts = {
			sources = {
				enabled_providers = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"ripgrep",
				}
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				ripgrep = {
					module = "blink-ripgrep",
					name = "Ripgrep",
					-- the options below are optional, some default values are shown
					---@module "blink-ripgrep"
					---@type blink-ripgrep.Options
					opts = {
						-- the minimum length of the current word to start searching
						-- (if the word is shorter than this, the search will not start)
						prefix_min_len = 3,
						-- The number of lines to show around each match in the preview window
						context_size = 5,
					},
				}
			},
			highlight = {
				-- sets the fallback highlight groups to nvim-cmp's highlight groups
				-- useful for when your theme doesn't support blink.cmp
				-- will be removed in a future release, assuming themes add support
				use_nvim_cmp_as_default = true,
			},
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- adjusts spacing to ensure icons are aligned
			nerd_font_variant = "normal",

			-- experimental auto-brackets support
			accept = { auto_brackets = { enabled = true } },

			-- experimental signature help support
			trigger = { signature_help = { enabled = true } },

			keymap = {

				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
				['<C-e>'] = { 'select_and_accept' },
				--['<C-y>'] = { 'select_and_accept' },
				['<ESC>'] = { 'hide', 'fallback' },

				['<C-p>'] = { 'select_prev', 'fallback' },
				['<C-n>'] = { 'select_next', 'fallback' },



				['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

				['<Tab>'] = { 'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			},
			windows = {
				ghost_text = {
					enabled = true,
				}
			}
		}
	},
	-- {
	--     "hrsh7th/nvim-cmp",
	--     dependencies = {
	--         "hrsh7th/cmp-nvim-lsp",
	--         "hrsh7th/cmp-nvim-lua",
	--         "hrsh7th/cmp-buffer",
	--         "hrsh7th/cmp-path",
	--         "hrsh7th/cmp-nvim-lsp-signature-help",
	--         "L3MON4D3/LuaSnip",
	--         "saadparwaiz1/cmp_luasnip",
	--         "windwp/nvim-autopairs",
	--     },
	--     opts = {
	--         sources = {
	--             { name = "nvim_lsp" },
	--             { name = "nvim_lsp_signature_help" },
	--             { name = "luasnip" },
	--             { name = "buffer" },
	--             { name = "path" },
	--             { name = "lazydev", group_index = 1 },
	--         },
	--     },
	--     config = function(_, opts)
	--         vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
	--         local has_words_before = function()
	--             unpack = unpack or table.unpack
	--             local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	--             return col ~= 0
	--                 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	--         end
	--
	--         local border = {
	--             { "╭", "CmpBorder" },
	--             { "─", "CmpBorder" },
	--             { "╮", "CmpBorder" },
	--             { "│", "CmpBorder" },
	--             { "╯", "CmpBorder" },
	--             { "─", "CmpBorder" },
	--             { "╰", "CmpBorder" },
	--             { "│", "CmpBorder" },
	--         }
	--
	--         local cmp = require("cmp")
	--         local luasnip = require("luasnip")
	--         require("luasnip.loaders.from_vscode").lazy_load()
	--         local kind_icons = {
	--             Text = "",
	--             Method = "m",
	--             Function = "",
	--             Constructor = "",
	--             Field = "",
	--             Variable = "",
	--             Class = "",
	--             Interface = "",
	--             Module = "",
	--             Property = "",
	--             Unit = "",
	--             Value = "",
	--             Enum = "",
	--             Keyword = "",
	--             Snippet = "",
	--             Color = "",
	--             File = "",
	--             Reference = "",
	--             Folder = "",
	--             EnumMember = "",
	--             Constant = "",
	--             Struct = "",
	--             Event = "",
	--             Operator = "",
	--             TypeParameter = "",
	--         }
	--         cmp.setup {
	--             window = {
	--                 documentation = {
	--                     border = border,
	--                 },
	--                 completion = {
	--                     border = border,
	--                 },
	--             },
	--             snippet = {
	--                 expand = function(args)
	--                     luasnip.lsp_expand(args.body)
	--                 end,
	--             },
	--             mapping = cmp.mapping.preset.insert {
	--                 ["<C-k>"] = cmp.mapping.select_prev_item(),
	--                 ["<C-j>"] = cmp.mapping.select_next_item(),
	--                 ["<C-d>"] = cmp.mapping.scroll_docs(-4),
	--                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
	--
	--                 -- ["<C-space>"] = cmp.open_docs(),
	--                 ["<C-space>"] = cmp.mapping.complete(), -- open completion on ctrl+space
	--                 --[[ ["<CR>"] = cmp.mapping.confirm {
	--                     -- behavior = cmp.ConfirmBehavior.Replace,
	--                     select = true,
	--                 }, ]]
	--
	--                 ["<S-CR>"] = cmp.mapping {
	--                     i = function(fallback)
	--                         if cmp.visible() then
	--                             if luasnip.expandable() then
	--                                 luasnip.expand()
	--                             else
	--                                 cmp.confirm {
	--                                     select = true,
	--                                 }
	--                             end
	--                         else
	--                             fallback()
	--                         end
	--                     end,
	--                     s = cmp.mapping.confirm { select = true },
	--                     c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
	--                 },
	--
	--                 ["<Tab>"] = cmp.mapping(function(fallback)
	--                     if cmp.visible() then
	--                         cmp.select_next_item()
	--                     -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	--                     -- that way you will only jump inside the snippet region
	--                     elseif luasnip.expand_or_jumpable() then
	--                         luasnip.expand_or_jump()
	--                     elseif has_words_before() then
	--                         cmp.complete()
	--                     else
	--                         fallback()
	--                     end
	--                 end, { "i", "s" }),
	--
	--                 ["<S-Tab>"] = cmp.mapping(function(fallback)
	--                     if cmp.visible() then
	--                         cmp.select_prev_item()
	--                     elseif luasnip.jumpable(-1) then
	--                         luasnip.jump(-1)
	--                     else
	--                         fallback()
	--                     end
	--                 end, { "i", "s" }),
	--             },
	--             formatting = {
	--                 expandable_indicator = true,
	--                 fields = { "kind", "abbr", "menu" },
	--                 format = function(entry, vim_item)
	--                     -- Kind icons
	--                     vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
	--                     vim_item.menu = ({
	--                         nvim_lsp = "[LSP]",
	--                         luasnip = "[Snippet]",
	--                         buffer = "[Buffer]",
	--                         path = "[Path]",
	--                     })[entry.source.name]
	--                     return vim_item
	--                 end,
	--             },
	--             completion = {
	--                 -- keyword_length  1,
	--                 -- keyword_pattern = ".*",
	--             },
	--             experimental = {
	--                 ghost_text = {
	--                     hl_group = "CmpGhostText",
	--                 },
	--             },
	--             sources = opts.sources or {},
	--         }
	--
	--         cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	--     end,
	-- },
}

return {}

-- return {
-- 	{
-- 		"nvimdev/guard.nvim",
-- 		dependencies = {
-- 			"nvimdev/guard-collection",
-- 		},
--
-- 		keys = {
--
-- 			{
-- 				-- Customize or remove this keymap to your liking
-- 				"<leader>cf",
-- 				"<CMD>GuardFmt<CR>",
-- 				mode = "n",
-- 				desc = "Format buffer",
-- 			},
-- 		},
-- 		opts = {
-- 			fmt_on_save = true,
-- 			lsp_as_default_formatter = true,
-- 		},
-- 		config = function(_, opts)
-- 			local ft = require("guard.filetype")
--
-- 			-- lua
-- 			ft("lua"):fmt("lsp"):append("stylua"):lint("selene")
--
-- 			-- javascript/typescript
-- 			ft("typescript,javascript,typescriptreact"):fmt({
-- 				cmd = "prettierd",
-- 				args = { "--stdin-filepath" },
-- 				fname = true,
-- 				stdin = true,
-- 			}):lint("eslint_d")
-- 			--
-- 			require("guard").setup(opts)
-- 		end,
-- 	},
-- }
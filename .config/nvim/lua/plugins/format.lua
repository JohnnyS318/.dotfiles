-- formatting configuration
-- either using guard.nvim or conform.nvim

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "FormatDisable", "FormatEnable" },
		keys = {
			{ "<leader>cf", function() require("conform").format() end, desc = "Format Buffer Conform" }
		},
		opts = {
			formatters_by_ft = {
				markdown = { "markdownfmt" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				rust = { "rustfmt" },
				--tex = { "texfmt" },
				--latex = { "texfmt" },
				yaml = { "yamlfmt" },
				latex = { "latexindent" },
				tex = { "latexindent" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return {
					timeout_ms = 250,
					lsp_format = "fallback"
				}
			end,
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				texfmt = {
					command = "tex-fmt",
					args = { "--stdin" },
					stdin = true,
				},
				latexindent = {
					command = "latexindent",
					args = { "-m", "-l=.latexindent.yaml", "-" },
					stdin = true,
				}
			}
		},
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
	},
}

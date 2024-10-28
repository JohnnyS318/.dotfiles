-- formatting configuration
-- either using guard.nvim or conform.nvim

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{ "<leader>cf", function() require("conform").format() end, desc = "Format Buffer Conform" }
		},
		opts = {
			formatters_by_ft = {
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				rust = { "rustfmt" },
				tex = { "texfmt" },
				latex = { "texfmt" },
				--latex = { "latexindent" },
				--tex = { "latexindent" },
			},
			format_on_save = {
				timeout_ms = 250,
				lsp_format = "fallback"
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters = {
				texfmt = {
					command = "tex-fmt",
					args = { "--stdin" },
					stdin = true,
				}
			}
		}
	},
}

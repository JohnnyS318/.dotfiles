return {}

-- return {
--     {
--         "nvimdev/guard.nvim",
--         dependencies = {
--             "nvimdev/guard-collection",
--         },
--
--         layz = false,
--
--         keys = {
--             {
--                 -- Customize or remove this keymap to your liking
--                 "<leader>cf",
--                 "<CMD>GuardFmt<CR>",
--                 mode = "n",
--                 desc = "Format buffer",
--             },
--         },
--         opts = {
--             fmt_on_save = true,
--             lsp_as_default_formatter = true,
--         },
--         config = function(_, opts)
--             local ft = require("guard.filetype")
--
--             -- lua
--             ft("lua"):fmt("lsp"):append("stylua"):lint("selene")
--
--             -- javascript/typescript
--             ft("typescript,javascript,typescriptreact,javascriptreact"):fmt({
--                 cmd = "prettierd",
--                 args = { "--stdin-filepath" },
--                 fname = true,
--                 stdin = true,
--             }):lint("eslint_d")
--
--             --c
--             ft("c"):fmt("clang-format"):lint("clang-tidy")
--
--             ft("cpp"):fmt("clang-format"):lint("clang-tidy")
--
--             --codespell
--             ft("*"):lint("codespell")
--
--             vim.g.guard_config = opts
--         end,
--     },
-- }
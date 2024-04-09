-- ~/.config/nvim/after/ftplugin/haskell.lua
local ht = require("haskell-tools")
local bufnr = vim.api.nvim_get_current_buf()
-- haskell-language-server relies heavily on codeLenses,
-- so auto-refresh (see advanced configuration) is enabled by default
vim.keymap.set(
    "n",
    "<leader>cl",
    vim.lsp.codelens.run,
    { noremap = true, silent = true, buffer = bufnr, desc = "Refresh/Run Code Lenses" }
)
-- Hoogle search for the type signature of the definition under the cursor
vim.keymap.set(
    "n",
    "<leader>hs",
    ht.hoogle.hoogle_signature,
    { noremap = true, silent = true, buffer = bufnr, desc = "Hoogle Search" }
)
-- Evaluate all code snippets
vim.keymap.set(
    "n",
    "<leader>ea",
    ht.lsp.buf_eval_all,
    { noremap = true, silent = true, buffer = bufnr, desc = "Evaluate All Snippets" }
)
-- Toggle a GHCi repl for the current package
vim.keymap.set(
    "n",
    "<leader>rp",
    ht.repl.toggle,
    { noremap = true, silent = true, buffer = bufnr, desc = "GHCI repl package" }
)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set("n", "<leader>rb", function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, { noremap = true, silent = true, buffer = bufnr, desc = "GHCI repl buffer" })

-- Quit repl
vim.keymap.set("n", "<leader>rq", ht.repl.quit, { noremap = true, silent = true, buffer = bufnr, desc = "Quit repl" })

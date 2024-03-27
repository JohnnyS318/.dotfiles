local M = {}

M.on_attach = function(client, buffer)
    -- Code Actions
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, buffer = buffer, desc = "Rename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = buffer, desc = "Code Action" })
    vim.keymap.set(
        "n",
        "<leader>cd",
        vim.lsp.buf.type_definition,
        { silent = true, buffer = buffer, desc = "Type Definition" }
    )
    vim.keymap.set(
        "n",
        "<leader>cs",
        require("telescope.builtin").lsp_document_symbols,
        { silent = true, buffer = buffer, desc = "Document Symbols" }
    )
    vim.keymap.set("n", "<leader>cF", "<cmd>Format<cr>", { silent = true, buffer = buffer, desc = "Format with LSP" })

    -- GOTO
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = buffer, desc = "Goto Definition" })
    vim.keymap.set(
        "n",
        "gr",
        require("telescope.builtin").lsp_references,
        { silent = true, buffer = buffer, desc = "Goto References" }
    )
    vim.keymap.set(
        "n",
        "gI",
        vim.lsp.buf.implementation,
        { silent = true, buffer = buffer, desc = "Goto Implementation" }
    )
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, buffer = buffer, desc = "Goto Declaration" })

    -- Documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, buffer = buffer, desc = "Hover Documentation" })
    --vim.keymap.set("i", "<C-K>", vim.lsp.buf.hover, { silent = true, buffer = buffer, desc = "Hover Documentation" })
end

return M

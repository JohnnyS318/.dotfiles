--- These are the options keymap becoming available when a lsp attaches.
--- These include standard vim.lsp stuff but Lspsaga and more...
---@module "lsp-keymap"
---@author Jonas Schneider
---@license MIT

local M = {}

-- These are the options keymap becoming available when a lsp attaches.
-- These include standard vim.lsp stuff but Lspsaga and more...

M.on_attach = function(_, buffer)
    -- Code Actions
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { silent = true, buffer = buffer, desc = "Rename" })
    vim.keymap.set("n", "<F2>", "<CMD>Lspsaga rename<CR>",
        { silent = true, buffer = buffer, desc = "Rename Project Wide" })
    vim.keymap.set("n", "<leader>cR", "<CMD>Lspsaga rename<CR>",
        { silent = true, buffer = buffer, desc = "Rename Project Wide" })
    -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = buffer, desc = "Code Action" })

    vim.keymap.set(
        "n",
        "<leader>ca",
        "<CMD>Lspsaga code_action<CR>",
        { silent = false, buffer = buffer, desc = "Code Action" }
    )

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
    vim.keymap.set(
        "n",
        "K",
        "<CMD>Lspsaga hover_doc<CR>",
        { silent = true, buffer = buffer, desc = "Hover Documentation" }
    )

    vim.keymap.set("i", "<C-K>", vim.lsp.buf.signature_help,
        { silent = true, buffer = buffer, desc = "Hover Signature Help" })

    -- Other Information

    vim.keymap.set(
        "n",
        "<leader>ch",
        "<CMD>Lspsaga incoming_calls<CR>",
        { silent = true, buffer = buffer, desc = "Hover Documentation" }
    )
    vim.keymap.set(
        "n",
        "<leader>ch",
        "<CMD>Lspsaga outgoing_calls<CR>",
        { silent = true, buffer = buffer, desc = "Hover Documentation" }
    )

    -- Diagnostics

    local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
            go { severity = severity }
        end
    end

    vim.keymap.set("n", "]d", diagnostic_goto(true), { silent = false, buffer = buffer, desc = "Next Diagnostics" })
    vim.keymap.set("n", "[d", diagnostic_goto(false), { silent = false, buffer = buffer, desc = "Prev Diagnostics" })
    vim.keymap.set("n", "[e", diagnostic_goto(true, "ERROR"), { silent = false, buffer = buffer, desc = "Next Error" })
    vim.keymap.set("n", "]e", diagnostic_goto(false, "ERROR"), { silent = false, buffer = buffer, desc = "Prev Error" })
    vim.keymap.set("n", "[w", diagnostic_goto(true, "WARN"), { silent = false, buffer = buffer, desc = "Next Warning" })
    vim.keymap.set(
        "n",
        "]w",
        diagnostic_goto(false, "WARN"),
        { silent = false, buffer = buffer, desc = "Prev Warning" }
    )
end

return M

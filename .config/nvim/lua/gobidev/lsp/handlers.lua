local M = {}

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = true,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "single",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "single",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "single",
	})
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = true,
		signs = true,
		update_in_insert = true,
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function format()
    local disabled_formatter = {
        svelte = true,
        tsserver = true,
        cssls = true,
        html = true,
        jsonls = true,
        sumneko_lua = true,
        pylsp = true,
        taplo = true,
        dockerls = true,
    }

    vim.lsp.buf.format {
        filter = function(client)
            -- Disable formatting for some language servers
            if disabled_formatter[client.name] then return false end

            -- Disable formatter of null-ls if formatting is provided by another LSP
            if client.name ~= 'null-ls' then return true end
            local clients = vim.lsp.buf_get_clients()
            local has_other_formatter = false
            for _, lsp in ipairs(clients) do
                if
                    lsp.name ~= 'null-ls'
                    and lsp.server_capabilities.documentFormattingProvider
                    and not disabled_formatter[lsp.name]
                then
                    has_other_formatter = true
                end
            end
            if has_other_formatter then return false end
            return true
        end,
    }
end

local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr, silent = true }
	local map = vim.keymap.set
	local builtin = require("telescope.builtin")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map("n", "gD", vim.lsp.buf.declaration, opts)
	map("n", "gd", builtin.lsp_definitions, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "gi", builtin.lsp_implementations, opts)
	map("n", "<leader>ld", builtin.lsp_type_definitions, opts)
	map("n", "<leader>lr", vim.lsp.buf.rename, opts)
	map("n", "<leader>la", require("code_action_menu").open_code_action_menu, opts)
	map("n", "<leader>lR", builtin.lsp_references, opts)
	map("n", "<leader>lD", vim.diagnostic.open_float, opts)
	map("n", "[d", vim.diagnostic.goto_prev, opts)
	map("n", "]d", vim.diagnostic.goto_next, opts)
	map("n", "]D", builtin.diagnostics, opts)
	map("n", "<leader>lf", format, opts)
	-- Get signatures (and _only_ signatures) when in argument lists.
	local lsp_signature_status_ok, lsp_signature = pcall(require, "lsp_signature")
	if not lsp_signature_status_ok then
		return
	end
	lsp_signature.on_attach({
		bind = true,
		handler_opts = {
			border = "single",
		},
	}, bufnr)
end

M.on_attach = function(client, bufnr)
	-- Add mappings
	lsp_keymaps(bufnr)
	-- LSP based highlighting
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M

local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    return
end

require("gobidev.lsp.lsp-installer")
require("gobidev.lsp.handlers").setup()

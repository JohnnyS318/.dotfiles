local M = {}

M.setup = function(base_on_attach, capabilities)
    return {
        on_attach = base_on_attach,
        capabilities = capabilities,
        settings = {
            html = {
                format = {
                    templating = true,
                    wrapAttributes = "auto",
                },
                hover = {
                    documentation = true,
                    references = true,
                },
            },
        },
    }
end

return M

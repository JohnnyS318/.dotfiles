local M = {}

M.setup = function(base_on_attach, capabilities)
    return {
        on_attach = base_on_attach,
        capabilities = capabilities,
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                format = {
                    enable = true,
                },
                validate = {
                    enable = true,
                },
            },
        },
    }
end

return M

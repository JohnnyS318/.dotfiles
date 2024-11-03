local M = {}

M.settings = {
    gopls = {
        hints = {
            rangeVariableTypes = true,
            parameterNames = true,
            constantValues = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            functionTypeParameters = true,
        },
    }
}

M.setup = function(base_on_attach, capabilities)
    return {
        on_attach = base_on_attach,
        capabilities = capabilities,
        settings = M.settings
    }
end

return M

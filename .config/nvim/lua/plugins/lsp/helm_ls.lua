local M = {}

M.setup = function(base_on_attach, capabilities)
    return {
        on_attach = base_on_attach,
        capabilities = capabilities,
        logLevel = "info",
        valuesFiles = {
            mainValuesFile = "values.yaml",
            lintOverlayValuesFile = "values.lint.yaml",
            additionalValuesFilesGlobPattern = "values*.yaml",
        },
        yamlls = {
            enabled = true,
            diagnosticsLimit = 50,
            showDiagnosticsDirectly = false,
            path = "yaml-language-server",
            config = {
                schemas = {
                    kubernetes = "templates/**",
                },
                completion = true,
                hover = true,
                -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
            },
        },
    }
end

return M

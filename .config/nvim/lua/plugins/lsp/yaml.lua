local M = {}

--- setup outsourced from lsp config for clarification
---@param on_attach  function The on_attach function that should be merged
---@param capabilities any The capabilities that should be merged
---@return any
M.setup = function(on_attach, capabilities)
    local cfg = require("yaml-companion").setup {
        builtin_matchers = {
            kubernetes = { enabled = true },
        },
        schemas = {

            -- not loaded automatically, manually select with
            -- :Telescope yaml_schema
            {
                name = "Argo CD Application",
                uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
            },
            {
                name = "SealedSecret",
                uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json",
            },
            -- schemas below are automatically loaded, but added
            -- them here so that they show up in the statusline
            {
                name = "Kustomization",
                uri = "https://json.schemastore.org/kustomization.json",
            },
            {
                name = "GitHub Workflow",
                uri = "https://json.schemastore.org/github-workflow.json",
            },
        },
        lspconfig = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    validate = true,
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require("schemastore").yaml.schemas(),
                },
            },
        },
    }
    return cfg
end

return M

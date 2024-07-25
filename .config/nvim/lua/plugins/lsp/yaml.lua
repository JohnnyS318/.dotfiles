local M = {}

--- setup outsourced from lsp config for clarification
---@param on_attach  function The on_attach function that should be merged
---@param capabilities any The capabilities that should be merged
---@return any
M.setup = function(on_attach, capabilities)
    local cfg = require("yaml-companion").setup {
        builtin_matchers = {
            kubernetes = { enabled = true },
            cloud_init = { enabled = true },
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
            {
                name = "Kubernetes 1.30.2",
                uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.2-standalone-strict/all.json",
            },
        },
        -- lspconfig = {
        --     on_attach = on_attach,
        --     capabilities = capabilities,
        --     settings = {
        --         yaml = {
        --             validate = true,
        --             schemaStore = {
        --                 enable = false,
        --                 url = "",
        --             },
        --             schemas = require("schemastore").yaml.schemas(),
        --         },
        --     },
        -- },
        lspconfig = {
            flags = {
                debounce_text_changes = 150,
            },
            settings = {
                redhat = { telemetry = { enabled = false } },
                yaml = {
                    validate = true,
                    format = { enable = true },
                    hover = true,
                    schemaStore = {
                        enable = true,
                        url = "https://www.schemastore.org/api/json/catalog.json",
                    },
                    schemaDownload = { enable = true },
                    schemas = {
                        kubernetes = "k8s-*.yaml",
                        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/**/*.{yml,yaml}",
                        ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                        ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                        ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                    },
                    trace = { server = "debug" },
                },
            },
        },
    }
    return cfg
end

return M

local M = {}

--- Extends the clangd on_attach function and adds a custom keymap for organizing imports.
---@param on_attach function(client, buffer) The base on_attach function to extend.
---@return function(client, buffer) A function that executes the wrapped on_attach function and extends it.
M.on_clangd_attach = function(on_attach)
    return function(client, buffer)
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client, buffer)
    end
end

M.cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
}
M.settings = {
    clangd = {
        InlayHints = {
            Designators = true,
            Enabled = true,
            ParameterNames = true,
            DeducedTypes = true,
            BlockEnd = true,
            TypenameLimit = 24,
        },
    },
}

M.init_options = {
    fallbackFlags = { "-std=c++23" },
}

return M

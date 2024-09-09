local M = {}

M.settings = {
    typescript = {
        preferences = {
            includeInlayVariableTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
        },
    },
}

M.filter = function(arr, fn)
    if type(arr) ~= "table" then
        return arr
    end

    local filtered = {}
    for k, v in pairs(arr) do
        if fn(v, k, arr) then
            table.insert(filtered, v)
        end
    end

    return filtered
end

M.filterReactDTS = function(value)
    return string.match(value.filename, "react/index.d.ts") == nil
end

M.on_list = function(options)
    local items = options.items
    if #items > 1 then
        items = M.filter(items, M.filterReactDTS)
    end

    vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
    vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
end

M.organize_ts_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(0) },
        title = "",
    }
    vim.lsp.buf.execute_command(params)
end

--- Extends the tsserver_attach function and adds a custom keymap for organizing imports.
---@param on_attach function(client, buffer) The base on_attach function to extend.
---@return function(client, buffer) A function that executes the wrapped on_attach function and extends it.
M.on_tsserver_attach = function(on_attach)
    return function(client, buffer)
        on_attach(client, buffer)

        vim.keymap.set("n", "<leader>ci", "<CMD>OrganizeImports<CR>")
    end
end

return M

---@module "filetypes"
---@author Jonas Schneider
---@license MIT

local M = {}

--- Registers custom filetypes to nvim at startup
M.register_filetypes = function()
    vim.filetype.add {
        extension = {
            mdx = "mdx",
        },
    }
end

--- Setup treesitter config of new custom filetypes
M.treesitter_setup = function()
    vim.treesitter.language.register("markdown", "mdx") -- register markdown parser to new mdx filetype
end

return M

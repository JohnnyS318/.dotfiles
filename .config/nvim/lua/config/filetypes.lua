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
    vim.filetype.add {
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
    }

    -- YAML
    vim.filetype.add {
        extension = {
            yml = "yaml.ansible"
        },
        pattern = {
            [".*/host_vars/.*%.ya?ml"] = "yaml.ansible",
            [".*/group_vars/.*%.ya?ml"] = "yaml.ansible",
            [".*/group_vars/.*/.*%.ya?ml"] = "yaml.ansible",
            [".*/playbook.*%.ya?ml"] = "yaml.ansible",
            [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
            [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
            [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
            [".*/tasks/.*%.ya?ml"] = "yaml.ansible",
            [".*/molecule/.*%.ya?ml"] = "yaml.ansible",
            [".*/ansible/.*%.yml"] = "yaml.ansible"
        }
    }

    vim.filetype.add {
        pattern = {
            [".*/%.gitlab%-ci.*%.ya?ml"] = "yaml.gitlab"
        }
    }

    vim.filetype.add {
        pattern = {
            [".*/docker%-compose%.ya?ml"] = "yaml.docker-compose",
            [".*/compose%.ya?ml"] = "yaml.docker-compose"
        }
    }
end

--- Setup treesitter config of new custom filetypes
M.treesitter_setup = function()
    vim.treesitter.language.register("markdown", "mdx") -- register markdown parser to new mdx filetype
end

return M

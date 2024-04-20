require("core.lazy")

-- global keymappings not dependent on some specific plugin
require("config.global-keymaps")

require("config.autocommands")

require("config.filetypes").register_filetypes()

require("config.spell")

if vim.g.neovide then
    require("config.neovide")
end

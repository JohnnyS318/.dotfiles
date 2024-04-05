require("core.lazy")

-- global keymappings not dependent on some specific plugin
require("config.global-keymaps")

require("config.filetypes").register_filetypes()

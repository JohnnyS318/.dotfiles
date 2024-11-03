local M = {}

M.settings = {
    ['rust-analyzer'] = {
        diagnostics = {
            enable = true,
        },
        check = {
            command = "clippy"
        },
        inlayHints = {
            chainingHints = {
                enable = true,
            },
            genericParameterHints = {
                lifetime = {
                    enable = true,
                },
                type = {
                    enable = true,
                },
            },
            paramterHints = {
                enable = true
            },
            typeHints = {
                enable = true,
            }
        }
    }
}

M.setup = function(base_on_attach, capabilities)
	return {
		on_attach = base_on_attach,
		capabilities = capabilities,
		settings = M.settings,
	}
end

return M

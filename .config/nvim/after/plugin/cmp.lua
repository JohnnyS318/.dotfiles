local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        -- Tab immediately completes. C-n/C-p to select.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        -- Ctrl+Space to show completions
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'path' },
    }),
    experimental = {
        ghost_text = true,
    },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    })
})

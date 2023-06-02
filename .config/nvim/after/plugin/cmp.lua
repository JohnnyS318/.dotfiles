local cmp_status_ok, cmp = pcall(require, 'cmp')
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then return end

local check_backspace = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = '',
    Method = 'm',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert {
        -- Tab immediately completes or jumps in snippet. Ctrl+N/Ctrl+P to select.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm { select = true }
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),

        -- Shift+Tab selects previous item or jumps backwards in snippet.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
        -- Ctrl+Space to show completions
        ['<C-Space>'] = cmp.mapping.complete(),

        -- Ctrl+E to abort
        ['<C-E>'] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },

        -- Ctrl+U and Ctrl+D to scroll docs up and down respectively
        ['<C-U>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-D>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    },
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                nvim_lua = '[NVIM_LUA]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
                latex_symbols = '[LaTeX]',
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
    -- documentation = {
    --   border = true,
    -- },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}
-- Enable completing paths in :
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' },
    }, {
        { name = 'cmdline' },
    }),
})

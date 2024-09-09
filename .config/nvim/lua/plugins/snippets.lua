return {
    {
        "mireq/luasnip-snippets",
        dependencies = { "LL3MON4D3/LuaSnip" },
        init = function()
            -- Mandatory setup function
            require("luasnip_snippets.common.snip_utils").setup()
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        version = "v2.*",
        build = "make install_jsregexp",
        init = function()
            local ls = require("luasnip")
            ls.setup {
                -- Required to automatically include base snippets, like "c" snippets for "cpp"
                load_ft_func = require("luasnip_snippets.common.snip_utils").load_ft_func,
                ft_func = require("luasnip_snippets.common.snip_utils").ft_func,
                -- To enable auto expansin
                enable_autosnippets = true,
                -- Uncomment to enable visual snippets triggered using <c-x>
                -- store_selection_keys = '<c-x>',
            }
        end,
    },
}

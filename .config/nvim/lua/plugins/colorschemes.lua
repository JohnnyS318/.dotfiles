return {
    {
        "navarasu/onedark.nvim",
        opts = {
            style = "darker",
        },
    },
    {
        "rebelot/kanagawa.nvim",
        --"jonsch318/forked-kanagawa.nvim",
        opts = {
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                }
            end
            -- colors = {
            --     theme = {
            --         wave = {
            --             ui = {
            --                 pemnu = {
            --                     bg       = "sumiInk4",
            --                     bg_sel   = "sumiInk5",
            --                     bg_sbar  = "sumiInk5",
            --                     bg_thumb = "sumiInk4",
            --                 }
            --             }
            --         },
            --         dragon = {
            --             ui = {
            --                 pemnu = {
            --                     bg       = "dragonBlack5",
            --                     bg_sel   = "dragonBlack6",
            --                     bg_sbar  = "dragonBlack6",
            --                     bg_thumb = "dragonBlack5",
            --                 }
            --             }
            --         },
            --         lotus = {
            --             ui = {
            --                 pemnu = {
            --                     bg       = "lotusWhite4",
            --                     bg_sel   = "lotusWhite5",
            --                     bg_sbar  = "lotusWhite5",
            --                     bg_thumb = "lotusWhite4",
            --                 }
            --             }
            --         }
            --     }
            -- }
        }
    },
    {
        "catppuccin/nvim",
    },
    {
        "ilof2/posterpole.nvim",
        priority = 1000,
    }
}

return {
    {
        "HakonHarnes/img-clip.nvim",
        even = "VeryLazy",
        opts = {},
        keys = {
            { "<LEADER>p", "<CMD>PasteImage<CR>", desc = "Paste Image " }
        }
    },
    {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end,
    },
}

return {
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup()
            -- vim.keymap.set("n")
        end,
        cmd = "Neogen",
    },
}

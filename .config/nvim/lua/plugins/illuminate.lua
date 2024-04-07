-- a plugin that highlights the current word and highlights other occurances under the cursor
return {
    {
        "RRethy/vim-illuminate",
        event = "BufReadPre",
        opts = {},
        config = function(_, opts)
            require("illuminate").configure(opts)
        end,
    },
}

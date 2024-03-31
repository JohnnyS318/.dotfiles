-- YAML

return {
    {
        "chrisgrieser/nvim-spider",
        lazy = true,
        keys = {
            {
                "w",
                "<CMD>lua require('spider').motion('w')<CR>",
                mode = { "n", "o", "x", desc = "Spider-W" },
            },
            {
                "e",
                "<CMD>lua require('spider').motion('e')<CR>",
                mode = { "n", "o", "x", desc = "Spider-W" },
            },
            {
                "b",
                "<CMD>lua require('spider').motion('b')<CR>",
                mode = { "n", "o", "x", desc = "Spider-W" },
            },
        },
    },
}

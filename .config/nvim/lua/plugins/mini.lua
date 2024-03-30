return {
    {
        "echasnovski/mini.bufremove",
        keys = {
            {
                "<leader>bd",
                function()
                    local bd = require("mini.bufremove").delete
                    if vim.bo.modified then
                        local choice =
                            vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
                        if choice == 1 then -- Yes
                            vim.cmd.write()
                            bd(0)
                        elseif choice == 2 then -- No
                            bd(0, true)
                        end
                    else
                        bd(0)
                    end
                end,
                desc = "Delete Buffer",
            },
            {
                "<leader>bD",
                function()
                    require("mini.bufremove").delete(0, true)
                end,
                desc = "Delete Buffer (Force)",
            },
        },
    },
    {
        "echasnovski/mini.pairs",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },
    -- TODO: Evaluate these keybindings
    -- tpope/vim-surround ?
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                add = "<leader>csa",
                delete = "<leader>csd",
                find = "<leader>gsf",
                find_left = "<leader>gsF",
                highlight = "<leader>csh",
                replace = "<leader>csr",
                update_n_lines = "<leader>csn",
            },
        },
    },
    -- TODO: Switch to numTOStr/Comment.nvim and use
    {
        "echasnovski/mini.comment",
        opts = {
            mappings = {
                comment = "<leader>cc",
                comment_line = "<leader>cC",
                comment_visual = "<leader>cc",
                textobject = "<leader>cc",
            },
        },
    },
}

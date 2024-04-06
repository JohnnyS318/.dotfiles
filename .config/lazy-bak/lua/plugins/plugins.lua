return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.treesitter.language.register("markdown", "mdx")
      end
    end,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "towolf/vim-helm",
  },
  {
    "isobit/vim-caddyfile",
  },
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
  },
  {
    "lervag/vimtex",
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
  },
  {
    "AndrewRadev/tagalong.vim",
  },
  {
    "kkoomen/vim-doge",
  },
}

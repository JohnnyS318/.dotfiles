-- install packer if not present
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Colorscheme
    use"gruvbox-community/gruvbox"

    -- VIM enhancements
    use 'editorconfig/editorconfig-vim'
    use 'andymass/vim-matchup'
    use 'jiangmiao/auto-pairs'
    use 'tpope/vim-abolish'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- GUI enhancements
    use 'kyazdani42/nvim-web-devicons'
    use 'lukas-reineke/indent-blankline.nvim'
    use 'feline-nvim/feline.nvim'
    use {
        'wellle/context.vim',
        config = function()
            vim.g.context_add_mappings = false
            vim.g.context_highlight_border = '<hide>'
            vim.g.context_highlight_normal = 'PMenu'
        end,
    }

    -- better escape
    use {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    }

    -- Language Server
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-path"
    use "onsails/lspkind-nvim"
    use "nvim-lua/lsp_extensions.nvim"
    use "glepnir/lspsaga.nvim"
    use "simrat39/symbols-outline.nvim"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    
    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

end)

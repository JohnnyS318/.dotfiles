-- install packer if not present
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

ensure_packer()

-- reload nvim when packer.lua is written
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]])

-- use protected call to require packer so we don't get an error on first launch
local status_ok, packer = pcall(require, 'packer')
if not status_ok then return end

-- use popout window for packer
packer.init {
    display = {
        open_fn = function() return require('packer.util').float { border = 'single' } end,
    },
}

return packer.startup(function(use)
    -- Packer
    use('wbthomason/packer.nvim')

    -- Plugin dependencies
    use('nvim-lua/plenary.nvim')

    -- Colorscheme
    -- use { "ellisonleao/gruvbox.nvim" }
    use('gruvbox-community/gruvbox')

    -- VIM enhancements
    use('editorconfig/editorconfig-vim')
    use('andymass/vim-matchup')
    use('windwp/nvim-autopairs')
    use('tpope/vim-abolish')
    use('numToStr/Comment.nvim')

    -- GUI enhancements
    use('lukas-reineke/indent-blankline.nvim')
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
    }

    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    }

    -- Fuzzy Finder
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
    }

    -- cmp plugins
    use('hrsh7th/nvim-cmp') -- The completion plugin
    use('hrsh7th/cmp-buffer') -- buffer completions
    use('hrsh7th/cmp-path') -- path completions
    use('hrsh7th/cmp-cmdline') -- cmdline completions
    use('saadparwaiz1/cmp_luasnip') -- snippet completions
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')

    -- snippets
    use('L3MON4D3/LuaSnip') --snippet engine
    use('rafamadriz/friendly-snippets') -- a bunch of snippets to use

    -- LSP
    use { 'ur4ltz/surround.nvim' }
    use { 'tpope/vim-repeat' }
    use { 'weilbith/nvim-code-action-menu' }
    use('neovim/nvim-lspconfig') -- enable LSP
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')
    use('jayp0521/mason-null-ls.nvim')
    use {'kaarmu/typst.vim', ft = {'typst'}}
    use('RubixDev/mason-update-all')
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
        },
    }
    use('ray-x/lsp_signature.nvim')
    use('MunifTanjim/prettier.nvim')

    use {
        'preservim/vim-markdown',
        requires = { 'godlygeek/tabular' },
    }
    use { 'jghauser/follow-md-links.nvim' }

    -- Markdown preview
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update { with_sync = true }
            ts_update()
        end,
    }
    -- Telescope
    use('nvim-telescope/telescope.nvim')

    -- faster load times
    use('lewis6991/impatient.nvim')

    -- git
    use('lewis6991/gitsigns.nvim')

    -- clipboard
    -- use { 'ojroques/nvim-osc52' }
end)

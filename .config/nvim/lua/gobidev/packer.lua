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

ensure_packer()

-- reload nvim when packer.lua is written
vim.cmd([[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
    augroup end
]])

-- use protected call to require packer so we don't get an error on first launch
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- use popout window for packer
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "single" })
        end,
    },
})

return packer.startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Plugin dependencies
    use "nvim-lua/plenary.nvim"

    -- Colorscheme
    use "gruvbox-community/gruvbox"

    -- VIM enhancements
    use 'editorconfig/editorconfig-vim'
    use 'andymass/vim-matchup'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-abolish'
    use "numToStr/Comment.nvim"

    -- GUI enhancements
    use 'lukas-reineke/indent-blankline.nvim'
    use 'feline-nvim/feline.nvim'
    -- use {
    --     'wellle/context.vim',
    --     config = function()
    --         vim.g.context_add_mappings = false
    --         vim.g.context_highlight_border = '<hide>'
    --         vim.g.context_highlight_normal = 'PMenu'
    --     end,
    -- }

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer

    -- treesitter
    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- faster load times
    use "lewis6991/impatient.nvim"

    -- git
    use "lewis6991/gitsigns.nvim"


end)

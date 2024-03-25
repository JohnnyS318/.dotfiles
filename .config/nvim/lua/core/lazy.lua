-- first install lazy if it is not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- path to lazy
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })                     -- install if not there
end

vim.opt.rtp:prepend(lazypath)

-- copied this from github.com/frans-johansson/lazy-nvim-starter to protected against first install error

local ok, lazy = pcall(require, "lazy")
if not ok then
    return
end

-- require core vim constants/options especially mapleader " "
require("core.options")

lazy.setup("plugins")

require("core.color")

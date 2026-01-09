-- neovim init.lua

require('my/settings')
require('my/maps')
require('my/fileformats')

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("my/lazy") -- lazy.nvim plugin manager


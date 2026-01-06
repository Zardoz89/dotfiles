-- ~/nvim/lua/plugins/molokai_colorscheme.lua

return {
    "tomasr/molokai",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme molokai")
        vim.cmd("highlight ColorColumn ctermbg=red ctermfg=white guibg=#351818")
        vim.cmd("highlight OverLength ctermbg=red ctermfg=white guibg=#592929")
        vim.cmd([[match OverLength /\%121v.\+/]])
    end,
}




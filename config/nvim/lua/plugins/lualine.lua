-- lualine.lua

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
      "UtkarshVerma/molokai.nvim",
    },
    config = function()
        require("lualine").setup --()
        {
          options = {
            theme = 'molokai'
          }
        }
    end,
}

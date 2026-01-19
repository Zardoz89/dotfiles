local highlight = {
  "CursorColumn",
  "Whitespace",
}

return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  --main = "ibl",
  -----@module "ibl"
  -----@type ibl.config
  --opts = {},
  config = function()
    require("ibl").setup {
      --indent = { highlight = highlight, char = "" },
      --whitespace = { highlight = { "Whitespace", "NonText" } },
      indent = { char = "▏" },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
      scope = { enabled = true },
    }
  end,
}

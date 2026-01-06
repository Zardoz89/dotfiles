-- Manager de LSPs

return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {"mason-org/mason.nvim", opts = {}},
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",       -- LUA
        "vimls",        -- Vim script
        "ts_ls",        -- JavaScript / TypeScript
        "cssls",        -- CSS
        "html",         -- HTML
        "vue_ls",       -- Vue
        "eslint",       -- ESLint
        "lemminx",      -- XML & cia
        "bashls",
        "yamlls",

      },
    })
  end,
}

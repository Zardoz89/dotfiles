
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    ensure_installed ={
      "json",
      "javascript",
      "typescript",
      "tsx",
      "yaml",
      "html",
      "css",
      "scss",
      "csv",
      "d",
      "desktop",
      "diff",
      "dockerfile",
      "dtd",
      "editorconfig",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "http",
      "java",
      "javadoc",
      "jsodc",
      "markdown",
      "markdown_inline",
      "bash",
      "lua",
      "vim",
      "dockerfile",
      "gitignore",
      "c",
      "rust",
      "regex",
      "xml",
      "vue"
      },
      -- Instalar automáticamente parsers faltantes
      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },
    },
}


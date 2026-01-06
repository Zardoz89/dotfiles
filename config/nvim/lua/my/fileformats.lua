-- Config specific for files

local api = vim.api

-- Grupo para filetypes
local ft_group = api.nvim_create_augroup("filetypes", { clear = true })

-- Forzar filetype por extensión para LESS y Markdown
api.nvim_create_autocmd("BufRead", {
  group = ft_group,
  pattern = "*.less",
  callback = function()
    vim.bo.filetype = "less"
  end,
})

-- Overwrites SetMarkDownOptions function to set a custom config
--function _G.SetMarkdownOptions()
-- end

-- Makefile
api.nvim_create_autocmd("FileType", {
  group = ft_group,
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.smarttab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
  end,
})

-- Markdown
api.nvim_create_autocmd("FileType", {
  group = ft_group,
  pattern = "markdown",
  callback = function()
    --_G.SetMarkdownOptions()
    vim.opt_local.expandtab = true
    vim.opt_local.smarttab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.textwidth = 79
    vim.opt_local.colorcolumn = "80"
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.shiftround = false
  end,
})

-- XML
api.nvim_create_autocmd("FileType", {
  group = ft_group,
  pattern = "xml",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.smarttab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.tabstop = 4
    -- vim.bo.omnifunc = "xmlcomplete#CompleteTags"
  end,
})

-- -- Java
-- api.nvim_create_autocmd("FileType", {
--   group = ft_group,
--   pattern = "java",
--   callback = function()
--     vim.bo.omnifunc = "javacomplete#Complete"
--   end,
-- })
-- 
-- -- CSS family
-- api.nvim_create_autocmd("FileType", {
--   group = ft_group,
--   pattern = { "css", "less", "sass", "scss" },
--   callback = function()
--     vim.bo.omnifunc = "csscomplete#CompleteCSS"
--   end,
-- })
-- 
-- -- HTML
-- api.nvim_create_autocmd("FileType", {
--   group = ft_group,
--   pattern = "html",
--   callback = function()
--     vim.bo.omnifunc = "htmlcomplete#CompleteTags"
--   end,
-- })
--
-- -- JavaScript
-- api.nvim_create_autocmd("FileType", {
--   group = ft_group,
--   pattern = "javascript",
--   callback = function()
--     vim.bo.omnifunc = "javascriptcomplete#CompleteJS"
--   end,
-- })

-- JSON: comentarios // y /* */
api.nvim_create_autocmd("FileType", {
  group = ft_group,
  pattern = "json",
  callback = function()
    vim.cmd([[syntax match Comment +\/\/.\+$+]])
  end,
})

-- Git commit: spellcheck en español
api.nvim_create_autocmd("FileType", {
  group = ft_group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "es_es"
  end,
})


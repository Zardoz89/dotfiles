-- My settings for NeoVIM --
----------------------------

local global = vim.g
local o = vim.opt

-- Editor options --
--------------------

o.termguicolors = true  -- Color mode
o.syntax = "on"         -- Syntax coloring
o.background = "dark"
o.wrap = true           -- Enable line wrapping
o.mouse = "a"           -- Mousel enabled in all modes
o.number = true         -- Line number on the lateral

-- Use intelligent case while searching
-- If search string contains an upper case letter, disables ignorecase
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Identation
o.autoindent = true -- Copy indent from current line when starting a new line
o.copyindent = true
o.smarttab = true
o.tabstop = 2       -- a <Tab> are 2 spaces
o.shiftwidth = 2    -- Number of spaces to use for eacg step of (auto)indent
o.softtabstop = 2
o.expandtab = true  -- Pressing <Tab> puts spaces, and < or > for indenting

-- Buffers and split
o.hidden = true       -- When on a buffer becomes hidden when it is |abandon|ed
o.splitright = true   -- Split vertically to the right
o.splitbelow = true   -- Split horizontally below
o.title = true        -- When on, the title of the window will be set to the value of 'titlestring'
o.encoding = "UTF-8"  -- Sets the character encoding used inside Vim.
-- Show vertical guides at 80 and 120, highlight characters that go over 120 columns (by drawing a border on the 121st)
o.colorcolumn = { 80, 120 }

-- Status & Command bar
o.ruler = true    -- Show the line and column number of the cursor position, separated by a comma.
o.laststatus = 2  -- Seperate lines for state and mode
o.showmode = true -- Show current mode in the status line.
o.showcmd = true  -- Show the command in the status line.
o.cmdheight = 2   -- Better display for messages
o.updatetime = 300

-- Mostrar tabs, espacios y caracteres invisibles
o.list = true

o.listchars = {
  tab = "‣ ",
  nbsp = "␣",
  extends = "▶",
  trail = "·",
  eol = "↴",
}

-- Indicador de línea partida
o.showbreak = "↳ "

-- Color scheme
local ok, _ = pcall(vim.cmd, "colorscheme molokai")
if not ok then
  vim.cmd("colorscheme darkblue")
end

-- Folding
o.foldmethod = "syntax"
o.foldenable = false

-- Wildmenu
o.wildmenu = true

-- Backup
o.backupcopy = "yes"

-- Title
o.title = true

function _G.GitBranch()
  -- Ruta completa del archivo actual
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return ""
  end

  -- Directorio del archivo
  local dir = vim.fn.fnamemodify(file, ":p:h")
  -- Ejecutar git en ese directorio
  local cmd = 'git -C "' .. dir .. '" branch --show-current 2>/dev/null'
  local handle = io.popen(cmd)
  if not handle then
    return ""
  end

  local branch = handle:read("*a") or ""
  handle:close()

  branch = branch:gsub("%s+", "")
  if branch ~= "" then
    return " [rama:" .. branch .. "]"
  end

  return ""
end
-- Shows current file [git branch] - current working dir
o.titlestring = "%t%{v:lua.GitBranch()} - cwd:%{fnamemodify(getcwd(), ':t')} - nvim" 

-- Terminal options --
----------------------
o.shell = "/usr/bin/fish"


-- Cursor line --
-----------------

-- Only show cursorline in the current window and in normal mode
local cline_group = vim.api.nvim_create_augroup("cline", { clear = true })

vim.api.nvim_create_autocmd({ "WinLeave", "InsertEnter" }, {
  group = cline_group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "InsertLeave" }, {
  group = cline_group,
  pattern = "*",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})


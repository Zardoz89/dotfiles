-- My mappins for NeoVIM --
----------------------------

vim.g.mapleader = ","     -- Useful leader on Spanish keyboard

-- Ignore case wrapers of "w" and "q" commands
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

-- Black hole register
vim.keymap.set("n", "<leader>b", '"_', { noremap = true })

-- Delete current visual selection and dump in black hole buffer before pasting
-- Used when you want to paste over something without it getting copied to
-- Vim's default buffer
vim.keymap.set("v", "<leader>p", '"_dP', { noremap = true })


-- Ctrl-S to save file
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-s>", "<Esc>:w<CR>gv", { noremap = true, silent = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
-- Ctrl-R to reload actual file
vim.keymap.set("n", "<C-r>", ":e<CR>", { noremap = true, silent = true })

-- NeoVIM terminal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
vim.keymap.set("t", "<A-j>", [[<C-\><C-n><C-w>j]], { noremap = true })
vim.keymap.set("t", "<A-k>", [[<C-\><C-n><C-w>k]], { noremap = true })
vim.keymap.set("t", "<A-l>", [[<C-\><C-n><C-w>l]], { noremap = true })

-- Wrap visual navigation
local wrap_opts = { noremap = true, silent = true, buffer = true }

vim.keymap.set("n", "<Up>", "gk", wrap_opts)
vim.keymap.set("n", "<Down>", "gj", wrap_opts)
vim.keymap.set("n", "<Home>", "g<Home>", wrap_opts)
vim.keymap.set("n", "<End>", "g<End>", wrap_opts)

vim.keymap.set("i", "<Up>", "<C-o>gk", wrap_opts)
vim.keymap.set("i", "<Down>", "<C-o>gj", wrap_opts)
vim.keymap.set("i", "<Home>", "<C-o>g<Home>", wrap_opts)
vim.keymap.set("i", "<End>", "<C-o>g<End>", wrap_opts)


-- arrow keys for buffer switching
-- Shift+Up = Select buffer from list
-- Shift+Down = Last-used buffer
-- Shift+Left = Previous buffer
-- Shift+Right = Next buffer
-- Leader+c = Close current buffer but not closes split
vim.keymap.set("n", "<S-Up>", ":buffers<CR>:buffer ", { noremap = true })
vim.keymap.set("n", "<S-Down>", ":b#<CR>", { noremap = true })
vim.keymap.set("n", "<S-Left>", ":bp<CR>", { noremap = true })
vim.keymap.set("n", "<S-Right>", ":bn<CR>", { noremap = true })

vim.keymap.set("n", "<Leader>c", ":ene<CR>:bw #<CR>", { noremap = true })

-- Window navigation
vim.keymap.set("n", "<Leader><Up>", "<C-w><Up>", { noremap = true })
vim.keymap.set("n", "<Leader><Down>", "<C-w><Down>", { noremap = true })
vim.keymap.set("n", "<Leader><Left>", "<C-w><Left>", { noremap = true })
vim.keymap.set("n", "<Leader><Right>", "<C-w><Right>", { noremap = true })

-- Trailing spaces & Remove tabs stuff
vim.keymap.set("n", "<Leader>tl", function()
  local save = vim.fn.getreg("/")
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setreg("/", save)
  vim.cmd("nohl")
end, { silent = true })

vim.keymap.set("n", "<Leader>rt", function()
  local save = vim.fn.getreg("/")
  vim.cmd([[%s/\t/    /g]])
  vim.fn.setreg("/", save)
  vim.cmd("nohl")
end, { silent = true })

-- Debug syntax
vim.keymap.set("n", "<F10>", function()
  local line, col = vim.fn.line("."), vim.fn.col(".")
  local syn = vim.fn.synID
  local synattr = vim.fn.synIDattr
  local syntrans = vim.fn.synIDtrans

  print(
    "hi<" .. synattr(syn(line, col, 1), "name") ..
    "> trans<" .. synattr(syn(line, col, 0), "name") ..
    "> lo<" .. synattr(syntrans(syn(line, col, 1)), "name") .. ">"
  )
end)

-- Show list of keybindigns
--vim.keymap.set("n", "<leader>", ":WhichKey ','<CR>", { silent = true })

-- Append modeline after last line in buffer.
-- Use substitute() instead of printf() to handle '%%s' modeline in LaTeX files.
local function append_modeline()
  local modeline = string.format(
    " vim: set ts=%d sw=%d tw=%d %set :",
    vim.o.tabstop,
    vim.o.shiftwidth,
    vim.o.textwidth,
    vim.o.expandtab and "" or "no"
  )

  local comment = vim.o.commentstring:gsub("%%s", modeline)
  vim.api.nvim_buf_set_lines(0, -1, -1, false, { comment })
end

vim.keymap.set("n", "<Leader>ml", append_modeline, { silent = true })

-- Keep selected block when change indentation level
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Try to auto set encoding for working with old 8bit encodings
local function check_file_encoding()
  if vim.b.fenc_at_read and vim.bo.fileencoding ~= vim.b.fenc_at_read then
    vim.cmd("e! ++enc=" .. vim.bo.fileencoding)
    vim.b.fenc_at_read = nil
  end
end

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.txt", "*.prg", "*.csv", "*.cpp", "*.h", "makefile" },
  callback = function()
    vim.b.fenc_at_read = vim.bo.fileencoding
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = { "*.txt", "*.prg", "*.csv", "*.cpp", "*.h", "makefile" },
  callback = check_file_encoding,
})




--  vim: set ts=2 sw=2 tw=0 et :

-- nvim-tree.lua

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  --
  api.config.mappings.default_on_attach(bufnr)

  -- Overwrite/Undo mappins that manipulates the current buffer to avoid accidents

  vim.keymap.set("n", "<S-Up>", "<nop>", {buffer = bufnr})
  vim.keymap.set("n", "<S-Down>", "<nop>", {buffer = bufnr})

  -- Custom mappins
  --
  vim.keymap.set('n', '<S-Right>',  api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<S-Left>',   api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',          api.tree.toggle_help,                  opts('Help'))
end

return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { 
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        on_attach = my_on_attach,
      }
    end,
}


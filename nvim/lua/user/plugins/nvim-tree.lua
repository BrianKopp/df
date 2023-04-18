require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  renderer = {
    group_empty = true,
  },
})


vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>')


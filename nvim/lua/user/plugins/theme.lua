require('tokyonight').setup({
  style = "night",
  on_colors = function(colors)
    colors.fg_gutter = "#8da6b8"
  end,
})

vim.cmd[[colorscheme tokyonight-night]]


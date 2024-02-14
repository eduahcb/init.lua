
-- HORIZON THEME
-- vim.cmd.colorscheme("horizon")

--- TokyoNight Theme
vim.cmd.colorscheme("tokyonight-night")

-- require('lualine').setup({
  --   theme = 'tokyonight-night',
  -- })

--- Catppuccin
vim.cmd.colorscheme("catppuccin-macchiato")


require('lualine').setup({
    theme = 'catppuccin-macchiato',
  })



-- CSSS highlight
require('nvim-highlight-colors').setup {}

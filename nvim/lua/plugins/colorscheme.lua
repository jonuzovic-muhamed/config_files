CATPPUCIN_LATTE = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    vim.cmd.colorscheme("catppuccin-latte")
  end
}

CATPPUCIN_FRAPPE = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    vim.cmd.colorscheme("catppuccin-frappe")
  end
}

CATPPUCIN_MOCHA = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
  end
}

CATPPUCIN_MACCHIATO = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  config = function()
    vim.cmd.colorscheme("catppuccin-macchiato")
  end
}

TOKYONIGHT = {
  "folke/tokyonight.nvim",
  lazy = false,
  name = "tokyonight",
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme("tokyonight")
  end
}

return CATPPUCIN_MOCHA;

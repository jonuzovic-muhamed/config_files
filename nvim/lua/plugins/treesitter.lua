return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "html",
        "css",
        "go",
        "java",
        "python",
        "markdown",
        "markdown_inline",
      },
      auto_install = true,
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      fold = {
        enable = true,
      },
    })
  end,
}

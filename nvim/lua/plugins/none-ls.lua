return {
  "nvimtools/none-ls.nvim",
  -- dependencies = {
  --   "nvimtools/none-ls-extras.nvim",
  -- },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- JavaScript
        null_ls.builtins.formatting.prettier,
        -- Markup
        null_ls.builtins.diagnostics.markuplint,
        -- Lua
        null_ls.builtins.formatting.stylua,
        -- Python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}

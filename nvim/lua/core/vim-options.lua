-- General options
vim.g.mapleader = " "                      -- Leader Key to Space
vim.g.maplocalleader = "\\"
vim.opt.encoding = 'utf-8'                 -- Use UTF-8 encoding
vim.opt.fileencoding = 'utf-8'             -- Set file encoding to UTF-8
vim.opt.swapfile = false                   -- Enable/Disable swap files
vim.opt.backup = false                     -- Enable/Disable backup files
vim.opt.undofile = true                    -- Enable/Disable persistent undo
vim.opt.mouse = v
vim.opt.syntax = on

-- Disable netrw (because NvimTree Plugin)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Display options
vim.opt.number = true                      -- Show line numbers
vim.opt.relativenumber = true              -- Show relative line numbers
vim.opt.wrap = false                       -- Enable/Disable line wrapping
vim.opt.scrolloff = 8                      -- Keep 8 lines above/below cursor
vim.opt.signcolumn = 'yes'                 -- Always show the sign column
vim.opt.list = true                        -- Show whitespace characters
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Tab and indentation
vim.opt.tabstop = 2                        -- Number of spaces for a tab
vim.opt.shiftwidth = 2                     -- Number of spaces for autoindent
vim.opt.expandtab = true                   -- Use spaces instead of tabs
vim.opt.smartindent = true                 -- Enable smart indentation
vim.opt.smarttab = true

-- Clipboard
vim.opt.clipboard:append {'unnamed', 'unnamedplus'}   -- Use System Clipboard

-- Search options
vim.opt.ignorecase = true                  -- Ignore case in searches
vim.opt.smartcase = true                   -- Enable smart case
vim.opt.incsearch = true                   -- Show search results as you type
vim.opt.hlsearch = true                    -- Highlight search results

-- Performance options
vim.opt.lazyredraw = true                  -- Don't redraw while executing macros
vim.opt.history = 1000                     -- Keep a large command history

-- UI options
vim.opt.termguicolors = true               -- Enable 24-bit RGB color support
vim.opt.cursorline = false                 -- Highlight the current line
vim.opt.laststatus = 2                     -- Always show the status line
vim.opt.showmode = false                   -- Don't show mode in command line

-- Misc options
vim.opt.timeoutlen = 300                   -- Time to wait for a mapped sequence (ms)
vim.opt.updatetime = 300                   -- Faster completion (4000ms default)

-- Auto commands
vim.cmd([[ autocmd BufWritePre * :%s/\s\+$//e ]]) -- Remove trailing whitespace on save

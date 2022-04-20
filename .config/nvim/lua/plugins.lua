-- All vim plugins will be here

local Plug = vim.fn['plug#']

local pluglocation = vim.fn.stdpath('config') .. '/plugged'

vim.call('plug#begin', pluglocation)

-- Manage git better
Plug 'tpope/vim-fugitive'
-- Get faster at vim
Plug 'ThePrimeagen/vim-be-good'
-- Minimal line
Plug 'itchyny/lightline.vim'
-- Of course, the best color scheme
Plug 'gruvbox-community/gruvbox'
-- Language server protocol
Plug 'neovim/nvim-lspconfig'
-- Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
-- lsp king
Plug 'onsails/lspkind-nvim'
-- Tree-sitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})  -- We recommend updating the parsers on update
-- Telescope to see files better
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzy-native.nvim', { ['do'] = vim.fn['make'] })
-- Preview some markdown files
Plug('iamcco/markdown-preview.nvim', {['do'] = vim.fn['mkdp#util#install'], ['for'] = {'markdown', 'vim-plug'} } )
-- Debugger
Plug 'szw/vim-maximizer'
-- Plug 'puremourning/vimspector'
-- This is a comment
Plug 'numToStr/Comment.nvim'
-- AutoPairs
Plug 'windwp/nvim-autopairs'
Plug 'dstein64/vim-startuptime'
-- Lua Snip
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
-- Decompile support for csharp
Plug 'Hoffs/omnisharp-extended-lsp.nvim'

vim.call('plug#end')

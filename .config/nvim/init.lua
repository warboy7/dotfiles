
-- BASIC EDITOR SETTINGS

-- enable line number & relative line number
vim.opt.nu = true
vim.opt.relativenumber = true

-- fix indents
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- set leader key
vim.g.mapleader = " "

-- color term
vim.opt.termguicolors = true

-- remove highlight on search and enable incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- scroll options
vim.opt.scrolloff = 8

-- remove squigly lines
vim.opt.fillchars='eob: '

-- PACKAGE MANAGER
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
	-- which key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require('which-key').setup {}
		end,
	},
	-- file tree
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		version = "*",
		lazy = false,
	},
	-- tree sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function () 
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {"c", "lua", "python", "rust"},
				sync_install = false,
			highlight = { enable = true },
				indent = { enable = true },  
			})
		end,
	},
	-- Telescope
	{
		{
			'nvim-telescope/telescope.nvim', tag = '0.1.3',
			dependencies = {
				'nvim-lua/plenary.nvim'
			}
		}
	},
	-- autopairs
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		opts = {}
	},
	-- Indentline blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	-- LSP
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			{
				'williamboman/mason.nvim', config = true
			},
			{
				'williamboman/mason-lspconfig.nvim',
			}
		},
	},
	-- Autocomplete
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds a number of user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	-- Statusline
	{
		"nvim-lualine/lualine.nvim"
	},
	-- colorscheme
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
        priority = 1000
    },
    -- Comments
    {
        'numToStr/Comment.nvim',
        opts = {
        },
        lazy = false,
    },
    -- dashboard
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    }
})

-- [[vim-moonfly-colors]]
vim.cmd("colorscheme moonfly")

require "plugins.telescope"
require "plugins.lsp"
require "plugins.cmpnvim"
require "plugins.lualine"
require "plugins.commentnvim"
require "plugins.nvimtree"
require "plugins.indentblankline"
require "plugins.dashboard"

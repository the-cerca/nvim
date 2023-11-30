require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.4", requires = { { "nvim-lua/plenary.nvim" } } })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"m4xshen/autoclose.nvim",
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		"rebelot/kanagawa.nvim",
		"stevearc/conform.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-tree/nvim-web-devicons",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"mfussenegger/nvim-lint",
		"mhartington/formatter.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"mfussenegger/nvim-dap",
		"jose-elias-alvarez/null-ls.nvim",
		"saadparwaiz1/cmp_luasnip",
	})
end)

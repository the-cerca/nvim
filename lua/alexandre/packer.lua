require("packer").startup(function(use)
  use("wbthomason/packer.nvim")
  use({ "nvim-telescope/telescope.nvim", tag = "0.1.4", requires = { { "nvim-lua/plenary.nvim" } } })
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "folke/noice.nvim", requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } })
  use({
    "rcarriga/nvim-notify",
    "m4xshen/autoclose.nvim",
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    ------themes -----------
    "marko-cerovac/material.nvim",
    "olivercederborg/poimandres.nvim",
    "rebelot/kanagawa.nvim",
    "Mofiqul/dracula.nvim",
    --- end themes -----
    "stevearc/conform.nvim",
    "folke/trouble.nvim",
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
    use ({"L3MON4D3/LuaSnip", tag="v2.*", run="make install_jsregexp"}),
    use "rafamadriz/friendly-snippets",
    "mfussenegger/nvim-dap",
    "jose-elias-alvarez/null-ls.nvim",
    "saadparwaiz1/cmp_luasnip",
  })
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  })
  use({ "fatih/vim-go", run = ":GoUpdateBinaries" })
end)

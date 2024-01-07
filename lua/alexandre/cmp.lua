require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "luasnip" }, -- For luasnip users.
    { name = "nvim_lsp_signature_help" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = "buffer" },
  }),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("neodev").setup({
  {
    library = {
      enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
      -- these settings will be used for your Neovim config directory
      runtime = true, -- runtime path
      types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
      plugins = true, -- installed opt or start plugins in packpath
      -- you can also specify the list of plugins to make available as a workspace library
      -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
    },
    setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
    -- for your Neovim config directory, the config.library settings will be used as is
    -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
    -- for any other directory, config.library.enabled will be set to false
    override = function(root_dir, options) end,
    -- With lspconfig, Neodev will automatically setup your lua-language-server
    -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
    -- in your lsp start options
    lspconfig = true,
    -- much faster, but needs a recent built of lua-language-server
    -- needs lua-language-server >= 3.6.0
    pathStrict = true,
  },
})

-- Mason setup to ensure tools are installed
require("mason").setup({
  ensure_installed = {
    -- LSP
    "gopls",
    "tsserver",
    "svelte",
    "html",
    "cssls",
    "lua_ls",
    "luau_lsp",
    "htmx",
    -- Formatters
    "prettierd",
    "gofumpt",
    "stylelua",
    -- Linters
    "eslint_d",
    "stylelint-lsp",
    "golangci-lint",
    "stylelua",
  },
})
local lang = { "gopls", "tsserver", "svelte", "html", "cssls", "lua_ls", "htmx_lsp" }

-- Mason LSP config integration
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",
    "tsserver",
    "svelte",
    "html",
    "cssls",
    "lua_ls",
    "luau_lsp",
  },
  automatic_installation = true,
})

-- null-ls setup for formatting and linting
--local null_ls = require("null-ls")
--null_ls.setup({
--  sources = {
--    -- Formatters
--    null_ls.builtins.formatting.prettierd.with({
--      filetypes = { "typescript", "javascript", "svelte", "html", "css", "json" },
--    }),
--    null_ls.builtins.formatting.gofumpt.with({
--      filetypes = { "go" },
--    }),
--    --    null_ls.builtins.formatting.goimportsreviser.with({
--    --      filetypes = { "go" },
--    --    }),
--    null_ls.builtins.formatting.golines.with({
--      filetypes = { "go" },
--    }),
--    null_ls.builtins.formatting.stylua.with({
--      filetypes = { "lua" },
--    }),
--    -- Linters
--    null_ls.builtins.diagnostics.eslint_d,
--    null_ls.builtins.diagnostics.stylelint.with({
--      filetypes = { "css", "scss" },
--    }),
--    null_ls.builtins.diagnostics.golangci_lint,
--  },
--})

-- LSP config with on_attach function
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        -- New Neovim 0.7+ formatting function
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- LSP server configurations
local lspconfig = require("lspconfig")
lspconfig.gopls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.svelte.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.htmx.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.templ.setup({ on_attach = on_attach, capabilities = capabilities })
--for _, value in pairs(lang) do
--  lspconfig[value].setup({ on_attach = on_attach, capabilities = capabilities })
--end

-- Key mappings for manual formatting and linting
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.formatting_sync()
end, { noremap = true, silent = true })
-- Replace this with the path to your diagnostics signs configuration
-- Example:
vim.fn.sign_define("DiagnosticSignError", { text = "✖", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚠", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "➤", texthl = "DiagnosticSignHint" })

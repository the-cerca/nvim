local capabilities = require('cmp_nvim_lsp').default_capabilities()
require("mason").setup({
    automatic_installation = true
})
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "html", "cssls", "htmx", "jsonls", "tsserver", "marksman", "svelte", "tailwindcss", "gopls" },
})
local language_server = { "lua_ls", "html", "cssls", "htmx", "jsonls", "tsserver", "marksman", "svelte", "tailwindcss", "gopls" }
for _, l in ipairs(language_server) do
	require("lspconfig")[l].setup({
		capabilities = capabilities,
	})
end
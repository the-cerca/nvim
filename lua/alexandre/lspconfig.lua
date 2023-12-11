require("autoclose").setup()
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { { "prettierd", "prettier" } },
		go = { "goimports", "gofumt" },
	},
})

require("lint").linters_by_ft = {
	markdown = { "vale" },
	go = { "golangcilint" },
	lua = { "luacheck" },
	html = { "htmltidy" },
}

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
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup({
	automatic_installation = true,
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"html",
		"cssls",
		"htmx",
		"jsonls",
		"tsserver",
		"marksman",
		"svelte",
		"tailwindcss",
		"gopls",
	},
})
local server = { "lua_ls", "html", "cssls", "htmx", "jsonls", "tsserver", "marksman", "svelte", "tailwindcss", "gopls" }
for _, value in ipairs(server) do
	lspconfig[value].setup({
		capabilities = capabilities,
	})
end
require("lspconfig").gopls.setup({
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
	on_attach = function(client, bufnr)
		-- Organiser les imports lors de la sauvegarde du fichier
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.go" },
			callback = function()
				-- Cette fonction est appelée avant d'enregistrer le fichier Go
				local params = vim.lsp.util.make_range_params()
				params.context = { only = { "source.organizeImports" } }

				-- Perform the request for organizing imports
				local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
				for _, res in pairs(result or {}) do
					for _, action in pairs(res.result or {}) do
						if action.edit or (action.command and type(action.command) == "table") then
							if action.edit then
								vim.lsp.util.apply_workspace_edit(action.edit)
							end
							if action.command then
								local command = action.command
								if type(command) == "table" and command.command then
									command = command.command
								end
								vim.lsp.buf.execute_command(command)
							end
						end
					end
				end
			end,
		})
	end,
})

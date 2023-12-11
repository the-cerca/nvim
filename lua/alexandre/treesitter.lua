require("nvim-treesitter.configs").setup({
	ensure_installed = { "json", "sql", "lua", "go", "scss", "css", "html", "javascript", "typescript", "svelte" },
	auto_install = true,
	highlight = {
		additional_vim_regex_highlighting = false,
		enable = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	fold = {
		enable = true,
	},
})

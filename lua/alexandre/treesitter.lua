require('nvim-treesitter.configs').setup({
    ensure_installed = { 'json', 'sql', 'lua', 'go', 'scss', 'css', 'html', 'javascript', 'typescript' },
    auto_install = true,
    indent = {
        enable =  true
    }, 
    autotag = {
        enable = true
    }
})

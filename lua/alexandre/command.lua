--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--    callback = function()
--        require("lint").try_lint()
--    end,
--})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})
--local augroup = vim.api.nvim_create_augroup
--local autocmd = vim.api.nvim_create_autocmd
--augroup("__formatter__", { clear = true })
--autocmd("BufWritePost", {
--    group = "__formatter__",
--    command = ":FormatWrite",
--})

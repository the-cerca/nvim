local keymap = vim.keymap
vim.g.mapleader = " "
local builtin = require("telescope.builtin")
keymap.set("n", "<leader><space>", builtin.find_files, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})
----------------lsp---------------------
vim.api.nvim_set_keymap(
  "n",
  "<MiddleMouse>",
  "<cmd>lua vim.lsp.buf.definition()<CR>",
  { noremap = true, silent = true }
)

--------------- lsp ---------------------
local opts = { noremap = true, silent = true }
keymap.set("n", "<Tab>", "<C-w><C-w>", opts)
keymap.set("n", "vp", ":vsp<CR>", opts)
keymap.set("n", "qa", ":wqa<CR>", opts)
keymap.set("v", "cc", '"+y', opts)
keymap.set("n", "q", ":q<CR>", opts)
keymap.set("n", "nn", ":Format<CR>", opts)
-----------------------NeoTree----------------
keymap.set("n", "<leader>b", ":Neotree toggle<CR>", opts)
----------------------trouble----------------
-- Lua
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)
-------------------format---------------------
---- Mapping pour formatter le fichier courant
-- Key mapping for manual formatting
vim.keymap.set("n", "<leader>fm", function()
  vim.lsp.buf.formatting_sync()
end, { noremap = true, silent = true })
-------------lsp------------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

local keymap = vim.keymap
vim.g.mapleader = " "
local builtin = require("telescope.builtin")
keymap.set("n", "<leader><space>", builtin.find_files, {})
keymap.set("n", "<leader>fg", builtin.live_grep, {})
keymap.set("n", "<leader>fb", builtin.buffers, {})
keymap.set("n", "<leader>fh", builtin.help_tags, {})

local opts = { noremap = true, silent = true }
keymap.set("n", "<Tab>", "<C-w><C-w>", opts)
keymap.set("n", "vp", ":vsp<CR>", opts)
keymap.set("n", "qa", ":wqa<CR>", opts)
keymap.set("v", "cc", '"+y', opts)
keymap.set("n", "nn", ":Format<CR>", opts)
keymap.set("n", "q", ":q", opts)
keymap.set("n", "k", "j", opts)
keymap.set("n", "l", "k", opts)
keymap.set("n", "j", "l", opts)

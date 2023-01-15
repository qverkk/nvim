vim.g.mapleader = " "

-- Better navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "<a-cr>", vim.lsp.buf.code_action)
vim.keymap.set("v", "<a-cr>", vim.lsp.buf.code_action)

vim.keymap.set("n", "<c-a-l>", vim.lsp.buf.format)

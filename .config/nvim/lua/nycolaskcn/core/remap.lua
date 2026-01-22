vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set({"n", "v"}, "L", "$")
vim.keymap.set({"n", "v"}, "H", "0")

vim.keymap.set({"n", "v"}, "Y", "yy")
vim.keymap.set("v", "p", "\"_dP")

vim.keymap.set("n", "<leader><esc>", ":noh<CR>")
vim.keymap.set("n", "<leader>L", ":Lazy<CR>")

vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-l>", "<c-w>l")

vim.keymap.set("n", "<C-o>", "o<esc>")
vim.keymap.set("n", "<C-S-O>", "O<esc>")


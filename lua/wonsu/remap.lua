vim.g.mapleader = " "
vim.keymap.set("n", "<leader>q", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>o", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<CR>", ":bw<CR>", {buffer = true, noremap = true, silent = true})

-- Close all buffers without current one(closes and reopens current with save cursor position)
vim.keymap.set("n", "<leader>cb", function()
    vim.cmd(':w')
    local view = vim.fn.winsaveview()
    vim.cmd('%bd')
    vim.cmd('e#')
    vim.fn.winrestview(view)
    vim.cmd('redraw!')
end)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

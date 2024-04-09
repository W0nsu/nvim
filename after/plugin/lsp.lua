local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    --[[ 'omnisharp' ]]
    --[[ 'csharp_ls' ]]
})

local on_attach = function(_, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.on_attach(on_attach)

lsp.setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require('roslyn').setup({
    on_attach = on_attach,
    capabilities = capabilities
})

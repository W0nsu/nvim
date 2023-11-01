vim.g.OmniSharp_highlighting = 0
vim.g.OmniSharp_server_use_net6 = 1

local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.on_attach(function(_, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


end)

--[[lsp.configure('omnisharp', {
	handlers = {
		["textDocument/definition"] = require('omnisharp_extended').handler
	}
})]]

lsp.setup()

-- Setup neovim lua configuration
require('neodev').setup()

local lspconfig = require('lspconfig')
lspconfig.omnisharp.setup({
	enable_roslyn_analysers = true,
	enable_import_completion = true,
	organize_imports_on_format = true,
	filetypes = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props' },
	handlers = {
		["textDocument/definition"] = require('omnisharp_extended').handler,
	},
	cmd = { 'omnisharp' },
})

vim.diagnostic.config({
    virtual_text = true
})


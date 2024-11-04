local lsp = require("lsp-zero")

vim.filetype.add {
    extension = {
        templ = "templ"
    }
}

-- Register the LSP as a config
local configs = require 'lspconfig.configs'
if not configs.templ then
    configs.templ = {
        default_config = {
            cmd = { "templ", "lsp" },
            filetypes = { 'templ' },
            root_dir = require "lspconfig.util".root_pattern("go.mod", ".git"),
            settings = {},
        },
    }
end

lsp.preset("recommended")

lsp.ensure_installed({
    --[[ 'omnisharp' ]]
    --[[ 'csharp_ls' ]]
})

local custom_format = function()
    if vim.bo.filetype == "templ" then
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd('e!')
                end
            end,
        })
    else
        vim.lsp.buf.format()
    end
end

vim.api.nvim_create_autocmd({ "BufWritePre" }, { pattern = { "*" }, callback = custom_format })

local on_attach = function(_, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "ca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>rr", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "<leader>lf", custom_format, opts)
end

lsp.on_attach(on_attach)

lsp.setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
require('roslyn').setup({
    on_attach = on_attach,
    capabilities = capabilities
})

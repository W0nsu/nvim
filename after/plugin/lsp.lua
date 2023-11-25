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

lsp.setup()

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
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

local luasnip = require('luasnip')
luasnip.config.setup({
    enable_autosnippets = true,
    history = true
})

function create_namespace_from_path(path)
    -- Remove leading and trailing slashes
    path = path:gsub('^/', ''):gsub('/$', '')

    -- Replace remaining slashes with dots
    path = path:gsub('/', '.')

    return 'namespace ' .. path .. ';'
end

-- To see prints you need to do :messages in nvim
function get_namespace()
    -- Find full path to a file
    local fname = vim.api.nvim_buf_get_name(0)
    print('fname: ' .. fname)
    local util = require('lspconfig.util')

    -- Find full path to to folder that contains .csproj or .sln
    local root_pattern_result = util.root_pattern('*.csproj', '*.sln', '*.slnx')(fname)
    local path = root_pattern_result and vim.fn.fnamemodify(root_pattern_result, ':h') or ''
    print('path: ', path)

    if path == nil then
        path = ''
    end

    -- Remove everything before finding .sln and .csproj from full path.
    -- Should return path relative to project
    local result = fname:gsub(path .. '/', ''):gsub(path .. '\\', '')
    print('temp-result: ' .. result)

    -- Remove name of a file from namespace
    local no_fname = result:gsub('[\\/]?[a-zA-Z0-9_@]+.cs$', '')
    print('no_fname: ' .. no_fname)

    local namespace = create_namespace_from_path(no_fname)
    return namespace
end

local function get_class_name()
    local _, _, file_name = string.find(vim.api.nvim_buf_get_name(0), '([a-zA-Z_@<>0-9]+).cs')
    local name = file_name:gsub('.cs', ''):gsub('/', ''):gsub('\\', '')

    return name
end

local function get_class_with_namespace()
    local class_name = get_class_name()
    local namespace_name = get_namespace()
    local type = "class"

    if (class_name:sub(1, 1) == "I") then
        type = "interface"
    end

    return {
        namespace_name,
        [[]],
        'public ' .. type .. ' ' .. class_name,
        [[{]],
        [[]],
        '}'
    }
end

luasnip.add_snippets(nil, {
    cs = {
        luasnip.snippet({
            trig = 'namespace',
            name = 'add namesapce',
            dscr = 'Add namespace'
        },
        {
            luasnip.function_node(get_namespace, {})
        }
        ),
        luasnip.snippet({
            trig = 'class',
            name = 'class with namesapce',
            dscr = 'class with namesapce'
        },
        {
            luasnip.function_node(get_class_with_namespace, {})
        })
    }
})

luasnip.setup()

vim.diagnostic.config({
    virtual_text = true
})
-- Setup neovim lua configuration
require('neodev').setup()

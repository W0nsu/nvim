return {
  -- Git 
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  --

  -- LSP 
  {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      dependencies = {
          'neovim/nvim-lspconfig',
          'williamboman/mason.nvim',
          'williamboman/mason-lspconfig.nvim',
          'folke/neodev.nvim',
      }
  },
  --

  -- C#
  {
      'Hoffs/omnisharp-extended-lsp.nvim',
  },
  --

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
  --

  -- Pending keybinds 
  { 'folke/which-key.nvim', opts = {} },
  --

  -- Interface
  'folke/tokyonight.nvim',
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  --

  -- Files navigation
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  'theprimeagen/harpoon',
  --

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  --

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  --
}

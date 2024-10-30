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
      }
  },
  --

  -- C#
  {
      -- 'jmederosalvarado/roslyn.nvim',
      {
          "seblj/roslyn.nvim",
          ft = "cs",
          opts = {
              -- your configuration comes here; leave empty for default settings
          }
      },
      'jlcrochet/vim-razor',
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

  -- Interface
  'catppuccin/nvim',
  'rose-pine/neovim',
  {
      'rebelot/kanagawa.nvim',
      opts = {
          commentStyle = { italic = true },
          keywordStyle = { italic = true },
          statementStyle = { bold = true },

          transparent = true,  -- do not set background color
          dimInactive = false, -- dim inactive window `:h hl-NormalNC`
          terminalColors = true, -- define vim.g.terminal_color_{0,17}

          theme = "dragon",    --"wave" , "dragon", "lotus"

          overrides = function() -- add/modify highlights
              return {
                  NormalFloat = { bg = "none" },
                  FloatBorder = { bg = "none" },
                  FloatTitle = { bg = "none" },
              }
          end,

          colors = {
              theme = {
                  all = {
                      ui = {
                          bg_gutter = "none",
                      },
                  },
              },
          },
      },
  },
  'folke/tokyonight.nvim',
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'iceberg_dark',
        component_separators = '|',
        section_separators = '',
      },
    },
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

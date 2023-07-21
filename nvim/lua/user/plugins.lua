local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- My plugins here

  -- -- Theme
  -- use {
  --   'folke/tokyonight.nvim',
  --   config = function()
  --     require('user/plugins/theme')
  --   end,
  -- }

  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end,
  }


  -- Session saving
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/src", "~/src/bb", "~/src/personal", "~/src/public", "~/src/tutorials", "~/Downloads", "/"},
      }
    end
  }

  -- Git fugitive
  use {
    'tpope/vim-fugitive',
    requires = 'tpope/vim-rhubarb',
    config = function()
      require('user/plugins/fugitive')
    end,
  }

  -- VIM Maximizer
  use 'szw/vim-maximizer'

  -- Fuzzy search
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      require('user/plugins/telescope')
    end,
  }
  -- harpoon
  use {
    'ThePrimeagen/harpoon',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('user/plugins/harpoon')
    end,
  }

  -- Syntax hightlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('user/plugins/treesitter')
    end,
  }

  -- Treesitter Context
  use 'nvim-treesitter/nvim-treesitter-context'

  -- use {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v2.x',
  --   requires = {
  --     -- LSP Support
  --     {'neovim/nvim-lspconfig'},             -- Required
  --     {                                      -- Optional
  --       'williamboman/mason.nvim',
  --       run = function()
  --         pcall(vim.cmd, 'MasonUpdate')
  --       end,
  --     },
  --     {'williamboman/mason-lspconfig.nvim'}, -- Optional

  --     -- Autocompletion
  --     {'hrsh7th/nvim-cmp'},     -- Required
  --     {'hrsh7th/cmp-nvim-lsp'}, -- Required
  --     {'L3MON4D3/LuaSnip'},     -- Required
  --   },
  --   config = function()
  --     require('user/plugins/lsp')
  --   end,
  -- }

  -- LSP Server
  use {
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'jayp0521/mason-null-ls.nvim',
    },
    config = function()
      require('user/plugins/lspconfig')
    end,
  }

  -- Auto completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'onsails/lspkind-nvim',
    },
    config = function()
      require('user/plugins/cmp')
    end,
  }

  -- Visualize lsp progress
  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })

  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")

  -- NvimTree file editor
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/nvim-tree')
    end,
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('user/plugins/lualine')
    end,
  }

  -- Autopairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end,
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('user/plugins/autotag')
    end,
  }

  -- auto indent
  use {
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  }

  -- Github Copilot
  use {
    'github/copilot.vim',
  }

  use {
    'tpope/vim-surround',
  }

  use {
    'tpope/vim-commentary',
  }

  use {
    'vim-test/vim-test',
    config = function()
      require('user/plugins/vim-test')
    end,
  }

  -- Split Lines
  use {
    'AndrewRadev/splitjoin.vim',
    config = function()
      vim.g.splitjoin_php_method_chain_full = 1
      vim.g.splitjoin_trailing_comma = 1
    end,
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)


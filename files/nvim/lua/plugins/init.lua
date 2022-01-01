return require('packer').startup(
    function()
        -- Manage self
        use 'wbthomason/packer.nvim'

        -- base16 theme
        use {
            'RRethy/nvim-base16',
            config = function() require('plugins.nvim-base16') end,
        }

        -- Navigate between tmux and vim splits
        use 'christoomey/vim-tmux-navigator'

        -- Status line
        use {
            'Famiu/feline.nvim',
            -- The config queries the current colorscheme
            after = 'nvim-base16',
            config = function() require('plugins.feline') end,
        }

        -- Toggle comments
        use {
            'numToStr/Comment.nvim',
            config = function() require('plugins.Comment') end,
        }

        -- AST-based highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {'nvim-treesitter/playground'},
            run = ':TSUpdate',
            config = function() require('plugins.nvim-treesitter') end,
        }

        -- Indent lines
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function() require('plugins.indent-blankline') end,
        }

        -- Language servers
        use {
            'neovim/nvim-lspconfig',
            requires = {'hrsh7th/cmp-nvim-lsp'},
            config = function() require('plugins.nvim-lspconfig') end,
        }

        -- Function signature previews
        use {
            'ray-x/lsp_signature.nvim',
            config = function() require('plugins.lsp_signature') end,
        }

        -- Inlay hints for Rust
        use {
            'nvim-lua/lsp_extensions.nvim',
            config = function() require('plugins.lsp_extensions') end,
        }

        -- LSP autocompletion
        use {
            'hrsh7th/nvim-cmp',
            requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer'},
            config = function() require('plugins.nvim-cmp') end,
        }

        -- Code actions
        use {
            'kosayoda/nvim-lightbulb',
            config = function() require('plugins.nvim-lightbulb') end,
        }

        -- Linting
        use {
            'w0rp/ale',
            config = function() require('plugins.ale') end,
        }

        -- Show available keybindings
        use {
            'folke/which-key.nvim',
            config = function() require('plugins.which-key') end,
        }

        -- Colorize color values
        use {
            'norcalli/nvim-colorizer.lua',
            config = function() require('plugins.nvim-colorizer') end,
        }

        -- git sidebar indicators
        use {
            'lewis6991/gitsigns.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.gitsigns') end,
        }

        -- Code formatting
        use 'sbdchd/neoformat'

        -- Highlight TODOs
        use {
            'folke/todo-comments.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.todo-comments') end,
        }

        -- puppet highlighting
        use 'rodjek/vim-puppet'

        -- smali highlighting
        use 'kelwin/vim-smali'

        -- tmux.conf highlighting
        use 'tmux-plugins/vim-tmux'

        -- Fuzzy search
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.telescope') end,
        }
    end
)

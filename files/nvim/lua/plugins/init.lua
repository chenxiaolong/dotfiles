local status, packer = pcall(require, 'packer')
if not status then
    print 'packer is not installed'
    return
end

return packer.startup(
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

        -- Automatically detect indentation
        use {
            'nmac427/guess-indent.nvim',
            config = function() require('plugins.guess-indent') end,
        }

        -- AST-based highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            requires = {'nvim-treesitter/playground'},
            run = ':TSUpdate',
            config = function() require('plugins.nvim-treesitter') end,
        }

        -- A bunch of one-file mini-plugins
        use {
            'echasnovski/mini.nvim',
            config = function() require('plugins.mini') end,
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

        -- LSP bridge to external tools
        use {
            'jose-elias-alvarez/null-ls.nvim',
            requires = {
                'nvim-lua/plenary.nvim',
                'lewis6991/gitsigns.nvim',
            },
            config = function() require('plugins.null-ls') end,
        }

        -- LSP autocompletion
        use {
            'hrsh7th/nvim-cmp',
            requires = {
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-nvim-lsp',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/vim-vsnip',
                'Saecki/crates.nvim',
            },
            config = function() require('plugins.nvim-cmp') end,
        }

        -- Pretty list of diagnostics, code actions, etc.
        use {
            "folke/trouble.nvim",
            config = function() require('plugins.trouble') end,
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

        -- Clang
        use {
            'p00f/clangd_extensions.nvim',
            requires = {'neovim/nvim-lspconfig'},
            config = function() require('plugins.clangd_extensions') end,
        }

        -- Rust
        use {
            'simrat39/rust-tools.nvim',
            requires = {'neovim/nvim-lspconfig'},
            config = function() require('plugins.rust-tools') end,
        }

        -- Rust crates
        use {
            'Saecki/crates.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function() require('plugins.crates') end,
        }

        -- smali highlighting
        use 'kelwin/vim-smali'

        -- tmux.conf highlighting
        use 'tmux-plugins/vim-tmux'

        -- Fuzzy search
        use {
            'ibhagwan/fzf-lua',
            config = function() require('plugins.fzf-lua') end,
        }

        -- vim.ui implementation
        use 'stevearc/dressing.nvim'
    end
)

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazy_path,
    })
end
vim.opt.rtp:prepend(lazy_path)

require('lazy').setup({
    -- base16 theme
    {
        'RRethy/nvim-base16',
        config = function() require('plugins.nvim-base16') end,
    },

    -- Status line
    {
        'freddiehaddad/feline.nvim',
        -- The config queries the current colorscheme
        dependencies = {'nvim-base16'},
        config = function() require('plugins.feline') end,
    },

    -- Better messages UI
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
        },
        config = function() require('plugins.noice') end,
    },

    -- Toggle comments
    {
        'numToStr/Comment.nvim',
        config = function() require('plugins.Comment') end,
    },

    -- Automatically detect indentation
    {
        'nmac427/guess-indent.nvim',
        config = function() require('plugins.guess-indent') end,
    },

    -- AST-based highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {'nvim-treesitter/playground'},
        build = ':TSUpdate',
        config = function() require('plugins.nvim-treesitter') end,
    },

    -- A bunch of one-file mini-plugins
    {
        'echasnovski/mini.nvim',
        config = function() require('plugins.mini') end,
    },

    -- Indent lines
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function() require('plugins.indent-blankline') end,
    },

    -- Language servers
    {
        'neovim/nvim-lspconfig',
        dependencies = {'hrsh7th/cmp-nvim-lsp'},
        config = function() require('plugins.nvim-lspconfig') end,
    },

    -- Function signature previews
    {
        'ray-x/lsp_signature.nvim',
        config = function() require('plugins.lsp_signature') end,
    },

    -- LSP bridge to external tools
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'lewis6991/gitsigns.nvim',
        },
        config = function() require('plugins.null-ls') end,
    },

    -- LSP autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'Saecki/crates.nvim',
        },
        config = function() require('plugins.nvim-cmp') end,
    },

    -- Show available keybindings
    {
        'folke/which-key.nvim',
        config = function() require('plugins.which-key') end,
    },

    -- git sidebar indicators
    {
        'lewis6991/gitsigns.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('plugins.gitsigns') end,
    },

    -- Clang
    {
        'p00f/clangd_extensions.nvim',
        dependencies = {'neovim/nvim-lspconfig'},
        config = function() require('plugins.clangd_extensions') end,
    },

    -- Rust
    {
        'simrat39/rust-tools.nvim',
        dependencies = {'neovim/nvim-lspconfig'},
        config = function() require('plugins.rust-tools') end,
    },

    -- Rust crates
    {
        'Saecki/crates.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function() require('plugins.crates') end,
    },

    -- tmux.conf highlighting
    {
        'tmux-plugins/vim-tmux',
    },

    -- Fuzzy search
    {
        'ibhagwan/fzf-lua',
        config = function() require('plugins.fzf-lua') end,
    },

    -- vim.ui implementation
    {
        'stevearc/dressing.nvim',
    },
})

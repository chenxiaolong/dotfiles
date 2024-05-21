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
    -- Status line
    {
        'freddiehaddad/feline.nvim',
        config = function() require('plugins.feline') end,
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

    -- Language servers
    {
        'neovim/nvim-lspconfig',
        config = function() require('plugins.nvim-lspconfig') end,
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
})

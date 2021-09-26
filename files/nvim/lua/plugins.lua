return require('packer').startup(
    function()
        -- Manage self
        use 'wbthomason/packer.nvim'

        -- base16 theme
        use {
            'RRethy/nvim-base16',
            config = function()
                vim.cmd('colorscheme base16-tomorrow-night')
                -- For vim-airline-themes
                vim.g.base16colorspace = 256

                -- Unbold and dim NonText
                local utils = require('color_utils')
                local nontext = utils.get_highlight_options('NonText')
                local guifg = utils.multiply_color(nontext.guifg, 0.5)
                vim.cmd('highlight NonText gui=NONE guifg=' .. guifg)

                -- Unitalicize everything
                for name, options in pairs(utils.get_all_highlight_options()) do
                    if options.gui then
                        local modifiers = {}

                        for i in options.gui:gmatch('([^,]+)') do
                            if i ~= 'italic' then
                                table.insert(modifiers, i)
                            end
                        end

                        local new_gui = table.concat(modifiers, ',')
                        if new_gui ~= options.gui then
                            if new_gui == '' then
                                new_gui = 'NONE'
                            end

                            vim.cmd('highlight ' .. name .. ' gui=' .. new_gui)
                        end
                    end
                end
            end
        }

        -- Navigate between tmux and vim splits
        use 'christoomey/vim-tmux-navigator'

        -- Status line
        use {
            'vim-airline/vim-airline-themes',
            requires = 'vim-airline/vim-airline',
            config = function()
                vim.g.airline_powerline_fonts = 1
                -- Airline's base16 theme looks better than the matching
                -- base16_tomorrow_night theme
                vim.g.airline_theme = 'base16'
            end
        }

        -- Toggle comments
        use {
            'terrortylor/nvim-comment',
            config = function()
                require('nvim_comment').setup()
            end
        }

        -- AST-based highlighting
        use {
            'nvim-treesitter/nvim-treesitter',
            branch = '0.5-compat',
            run = ':TSUpdate',
            config = function()
                require 'nvim-treesitter.configs'.setup {
                    ensure_installed = 'maintained',
                    highlight = {
                        enable = true
                    },
                    indent = {
                        enable = true
                    }
                }
            end
        }

        -- Indent lines
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('indent_blankline').setup {
                    use_treesitter = true,
                    show_trailing_blankline_indent = false,
                    filetype_exclude = {'help'},
                    buftype_exclude = {'terminal'},
                }
            end
        }

        -- Language servers
        use {
            'neovim/nvim-lspconfig',
            config = function()
                local lspconfig = require('lspconfig')
                lspconfig.rust_analyzer.setup {}
            end
        }

        use {
            'nvim-lua/lsp_extensions.nvim',
            config = function()
                -- Show inlay hints for Rust
                vim.cmd([[autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require('lsp_extensions').inlay_hints()]])
            end
        }

        -- Code actions
        use {
            'kosayoda/nvim-lightbulb',
            config = function()
                vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
            end
        }

        -- Linting
        use {
            'w0rp/ale',
            config = function()
                -- Disable ruby linter
                vim.g.ale_linters = {ruby = {}}
            end
        }

        -- Show available keybindings
        use {
            'folke/which-key.nvim',
            config = function()
                require('which-key').setup {}
            end
        }

        -- Markdown preview
        use {
            'ellisonleao/glow.nvim',
            config = function()
                vim.g.glow_binary_path = ''
            end
        }

        -- Colorize color values
        use {
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup()
            end
        }

        -- git sidebar indicators
        use {
            'lewis6991/gitsigns.nvim',
            requires = {
                'nvim-lua/plenary.nvim'
            },
            config = function()
                require('gitsigns').setup()
            end
        }

        -- Code formatting
        use 'sbdchd/neoformat'

        -- Highlight TODOs
        use {
            'folke/todo-comments.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('todo-comments').setup {
                    signs = false
                }
            end
        }

        -- PKGBUILD highlighting
        use 'm-pilia/vim-pkgbuild'

        -- puppet highlighting
        use 'rodjek/vim-puppet'

        -- smali highlighting
        use 'kelwin/vim-smali'

        -- tmux.conf highlighting
        use 'tmux-plugins/vim-tmux'

        -- File search
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function()
                local bindings = {
                    fa = 'lsp_code_actions',
                    fb = 'buffers',
                    fc = 'command_history',
                    ff = 'find_files',
                    fg = 'live_grep',
                    fh = 'help_tags',
                    ft = 'treesitter',
                }

                for k, v in pairs(bindings) do
                    vim.api.nvim_set_keymap(
                        'n',
                        '<leader>' .. k,
                        '<cmd>lua require("telescope.builtin").' .. v .. '()<cr>',
                        {noremap = true}
                    )
                end
            end
        }
    end
)

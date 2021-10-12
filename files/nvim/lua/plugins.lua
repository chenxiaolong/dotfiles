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

                -- Colorize TSField (primarily for YAML)
                local colorscheme = require('colorscheme')
                colorscheme.highlight.TSField = 'TSVariable'

                -- Unbold and dim NonText
                local utils = require('color_utils')
                local nontext = utils.get_highlight_options('NonText')
                local guifg = utils.multiply_color(nontext.guifg, 0.5)
                vim.cmd('highlight NonText gui=NONE guifg=' .. guifg)

                -- Unitalicize everything
                for name, options in pairs(utils.get_all_highlight_options()) do
                    if options.gui then
                        local modifiers = {}

                        for i in vim.gsplit(options.gui, ',', true) do
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
                    },
                }

                local bindings = {
                    wn = 'print(ts_utils.get_node_at_cursor())',
                    wt = 'print(vim.inspect(ts_utils.get_node_text(ts_utils.get_node_at_cursor())))',
                }

                for k, v in pairs(bindings) do
                    vim.api.nvim_set_keymap(
                        'n',
                        '<leader>' .. k,
                        '<cmd>lua ts_utils = require("nvim-treesitter.ts_utils"); ' .. v .. '<cr>',
                        {noremap = true}
                    )
                end
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
            requires = {'hrsh7th/cmp-nvim-lsp'},
            config = function()
                local lspconfig = require('lspconfig')
                local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

                lspconfig.rust_analyzer.setup {
                    capabilities = capabilities,
                }
            end
        }

        -- Inlay hints for Rust
        use {
            'nvim-lua/lsp_extensions.nvim',
            config = function()
                vim.cmd([[autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require('lsp_extensions').inlay_hints()]])
            end
        }

        -- LSP autocompletion
        use {
            'hrsh7th/nvim-cmp',
            requires = {'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer'},
            config = function()
                local cmp = require('cmp')
                local autocomplete_key

                -- https://github.com/neovim/neovim/issues/13680
                -- https://github.com/libuv/libuv/pull/2535
                -- https://github.com/microsoft/terminal/issues/2865
                -- NOTE: Requires corresponding Windows Terminal setting
                if vim.fn.has('win32') then
                    autocomplete_key = '<C-S-Insert>'
                else
                    autocomplete_key = '<C-Space>'
                end

                cmp.setup {
                    mapping = {
                        -- Recommended key bindings from README
                        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        [autocomplete_key] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.close(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    },
                    sources = {
                        { name = 'nvim_lsp' },
                        { name = 'buffer' },
                    },
                    documentation = {
                        border = {
                            '┌', -- Top-left corner
                            '─', -- Top edge
                            '┐', -- Top-right corner
                            '│', -- Right edge
                            '┘', -- Bottom-right corner
                            '─', -- Bottom edge
                            '└', -- Bottom-left corner
                            '│', -- Left edge
                        },
                    },
                }
            end
        }

        -- Code actions
        use {
            'kosayoda/nvim-lightbulb',
            config = function()
                vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])

                -- neovim 0.5 on Windows uses a fork of libuv 1.34.2 (at commit:
                -- b899d12b0d56d217f31222da83f8c398355b69ef), which is missing
                -- a fix to support surrogate pairs, preventing emojis from
                -- displaying properly: https://github.com/libuv/libuv/pull/2971
                if vim.fn.has('win32') then
                    vim.fn.sign_define('LightBulbSign', { text = '?', texthl = 'LspDiagnosticsDefaultInformation' })
                end
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

        -- Fuzzy search
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim'},
            config = function()
                local bindings = {
                    -- General
                    fb = 'buffers',
                    fc = 'commands',
                    fC = 'command_history',
                    fg = 'live_grep',
                    fh = 'help_tags',
                    fs = 'search_history',
                    -- Files
                    fff = 'find_files',
                    ffo = 'oldfiles',
                    fft = 'filetypes',
                    -- Treesitter
                    ft = 'treesitter',
                    -- LSP
                    fla = 'lsp_code_actions',
                    fld = 'lsp_definitions',
                    fli = 'lsp_implementations',
                    flo = 'lsp_document_diagnostics',
                    flr = 'lsp_references',
                    flt = 'lsp_type_definitions',
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

local palette = require('utils.base16_palette')

require('mini.base16').setup({
    palette = palette,
})

-- Get rid of background behind status line and line numbers.
local color_utils = require('utils.color')

local function should_clear(name)
    return name == 'StatusLine'
        or name == 'StatusLineNC'
        or name == 'SignColumn'
        or vim.startswith(name, 'LineNr')
        or vim.startswith(name, 'GitSigns')
end

for name, options in pairs(color_utils.get_all_highlight_options()) do
    if should_clear(name) then
        if options.ctermbg == palette.base01 or options.ctermbg == palette.base02 then
            vim.cmd('highlight ' .. name .. ' ctermbg=NONE')
        end
        if options.guibg == palette.base01 or options.guibg == palette.base02 then
            vim.cmd('highlight ' .. name .. ' guibg=NONE')
        end
    end
end

local clue = require('mini.clue')
clue.setup({
    -- Suggested configuration from docs.
    clues = {
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
    },
    triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
    },
    window = {
        delay = 0,
        config = {
            width = 'auto',
        },
    },
})

require('mini.comment').setup()
require('mini.completion').setup()

local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        animation = indentscope.gen_animation.none(),
    },
})

local notify = require('mini.notify')
notify.setup()
vim.notify = notify.make_notify()

require('mini.trailspace').setup()

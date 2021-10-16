vim.cmd('colorscheme base16-tomorrow-night')

-- Colorize TSField (primarily for YAML)
local colorscheme = require('colorscheme')
colorscheme.highlight.TSField = 'TSVariable'

-- Unbold and dim NonText
local utils = require('utils.color')
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

local palette = require('utils.base16_palette')

require('mini.base16').setup({
    palette = palette,
})

-- Get rid of background behind line numbers
local color_utils = require('utils.color')

local function should_clear(name)
    return name == 'SignColumn'
        or vim.startswith(name, 'LineNr')
        or vim.startswith(name, 'GitSigns')
end

for name, options in pairs(color_utils.get_all_highlight_options()) do
    if should_clear(name) then
        if options.ctermbg == palette.base01 then
            vim.cmd('highlight ' .. name .. ' ctermbg=NONE')
        end
        if options.guibg == palette.base01 then
            vim.cmd('highlight ' .. name .. ' guibg=NONE')
        end
    end
end

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

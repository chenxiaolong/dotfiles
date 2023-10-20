require('mini.base16').setup({
    palette = require('utils.base16_palette'),
})

-- Get rid of background behind line numbers
vim.cmd('highlight LineNr guibg=NONE ctermbg=NONE')

require('mini.comment').setup()
require('mini.completion').setup()

local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        animation = indentscope.gen_animation.none(),
    },
})

require('mini.pick').setup()
require('mini.trailspace').setup()

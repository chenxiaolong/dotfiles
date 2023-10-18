require('mini.base16').setup({
    palette = require('utils.base16_palette'),
})

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

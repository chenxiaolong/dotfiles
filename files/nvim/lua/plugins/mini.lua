local indentscope = require('mini.indentscope')
indentscope.setup({
    draw = {
        animation = indentscope.gen_animation.none(),
    },
})

require('mini.trailspace').setup()

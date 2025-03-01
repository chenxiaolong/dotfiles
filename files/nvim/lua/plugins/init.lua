local deps = require('mini.deps')

deps.now(function() require('plugins.statusline') end)
deps.now(function() require('plugins.mini') end)
deps.now(function() require('plugins.nvim-treesitter') end)
deps.now(function() require('plugins.guess-indent') end)

deps.later(function() require('plugins.nvim-lspconfig') end)
deps.later(function() require('plugins.fzf-lua') end)
deps.later(function() require('plugins.gitsigns') end)
deps.later(function() require('plugins.crates') end)

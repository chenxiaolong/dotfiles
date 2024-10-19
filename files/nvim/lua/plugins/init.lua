local deps = require('mini.deps')

deps.now(function() require('plugins.feline') end)
deps.now(function() require('plugins.mini') end)
deps.now(function() require('plugins.nvim-treesitter') end)

deps.later(function() require('plugins.guess-indent') end)
deps.later(function() require('plugins.nvim-lspconfig') end)
deps.later(function() require('plugins.which-key') end)
deps.later(function() require('plugins.gitsigns') end)
deps.later(function() require('plugins.crates') end)

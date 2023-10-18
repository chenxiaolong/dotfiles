require('noice').setup({
    lsp = {
        signature = {
            enabled = false,
        },
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
        },
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
    -- No nerd fonts
    cmdline = {
        format = {
            cmdline = { icon = ">" },
            search_down = { icon = "🔍⌄" },
            search_up = { icon = "🔍⌃" },
            filter = { icon = "$" },
            lua = { icon = "☾" },
            help = { icon = "?" },
        },
    },
    format = {
        level = {
            icons = {
                error = "✖",
                warn = "▼",
                info = "●",
            },
        },
    },
    popupmenu = {
        kind_icons = false,
    },
    inc_rename = {
        cmdline = {
            format = {
                IncRename = { icon = "⟳" },
            },
        },
    },
})

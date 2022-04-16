local crates = require('crates')

-- Default configuration from the README for setups without patched fonts
crates.setup {
    text = {
        loading = "  Loading...",
        version = "  %s",
        prerelease = "  %s",
        yanked = "  %s yanked",
        nomatch = "  Not found",
        upgrade = "  %s",
        error = "  Error fetching crate",
    },
    popup = {
        text = {
            title = " # %s ",
            version = " %s ",
            prerelease = " %s ",
            yanked = " %s yanked ",
            feature = "   %s ",
            enabled = " * %s ",
            transitive = " ~ %s ",
        },
    },
    cmp = {
        text = {
            prerelease = " pre-release ",
            yanked = " yanked ",
        },
    },
}

local bindings = {
    ct = 'toggle',
    cr = 'reload',

    cv = 'show_versions_popup',
    cf = 'show_features_popup',

    cu = 'update_crate',
    cu = 'update_crates',
    ca = 'update_all_crates',
    cU = 'upgrade_crate',
    cU = 'upgrade_crates',
    cA = 'upgrade_all_crates',
}

for k, v in pairs(bindings) do
    vim.api.nvim_set_keymap(
        'n',
        '<leader>' .. k,
        '',
        {
            noremap = true,
            callback = crates[v],
        }
    )
end

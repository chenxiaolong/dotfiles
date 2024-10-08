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
            title = "# %s",
            pill_left = "",
            pill_right = "",
            created_label = "created        ",
            updated_label = "updated        ",
            downloads_label = "downloads      ",
            homepage_label = "homepage       ",
            repository_label = "repository     ",
            documentation_label = "documentation  ",
            crates_io_label = "crates.io      ",
            lib_rs_label = "lib.rs         ",
            categories_label = "categories     ",
            keywords_label = "keywords       ",
            version = "%s",
            prerelease = "%s pre-release",
            yanked = "%s yanked",
            enabled = "* s",
            transitive = "~ s",
            normal_dependencies_title = "  Dependencies",
            build_dependencies_title = "  Build dependencies",
            dev_dependencies_title = "  Dev dependencies",
            optional = "? %s",
            loading = " ...",
        },
    },
    completion = {
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
    vim.keymap.set(
        'n',
        '<leader>' .. k,
        crates[v]
    )
end

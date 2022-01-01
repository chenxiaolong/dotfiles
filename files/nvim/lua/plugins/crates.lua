-- Default configuration from the README for setups without patched fonts
require('crates').setup {
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

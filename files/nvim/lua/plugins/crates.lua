local crates = require('crates')

-- Default configuration from the README for setups without patched fonts
crates.setup({
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
})

local opts = { silent = true }
local function with_desc(desc)
    return vim.tbl_extend("force", opts, { desc = desc })
end

vim.keymap.set("n", "<leader>ct", crates.toggle, with_desc("Toggle UI elements"))
vim.keymap.set("n", "<leader>cr", crates.reload, with_desc("Reload data (clears cache)"))

vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, with_desc("Show crate versions"))
vim.keymap.set("n", "<leader>cf", crates.show_features_popup, with_desc("Show crate features"))
vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, with_desc("Show crate dependencies"))

vim.keymap.set("n", "<leader>cu", crates.update_crate, with_desc("Update current crate"))
vim.keymap.set("v", "<leader>cu", crates.update_crates, with_desc("Update selected crates"))
vim.keymap.set("n", "<leader>ca", crates.update_all_crates, with_desc("Update all crates"))
vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, with_desc("Upgrade current crate"))
vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, with_desc("Upgrade selected crates"))
vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, with_desc("Upgrade all crates"))

vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, with_desc("Extract into inline table"))
vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, with_desc("Extract into table"))

vim.keymap.set("n", "<leader>cH", crates.open_homepage, with_desc("Open homepage"))
vim.keymap.set("n", "<leader>cR", crates.open_repository, with_desc("Open repository"))
vim.keymap.set("n", "<leader>cD", crates.open_documentation, with_desc("Open documentation"))
vim.keymap.set("n", "<leader>cC", crates.open_crates_io, with_desc("Open crates.io"))

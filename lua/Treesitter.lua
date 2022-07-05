local p, treesitter = pcall(require, "nvim-treesitter.configs")

if not p then return end

Setup = {
    ensure_installed = {"c", "lua", "javascript", "commonlisp", "haskell"},
    sync_install = false,
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true
    }
}

return function ()
    treesitter.setup(Setup)
end

require "options"()
require "keymaps"()
require "plugins"()
require "aesthetics"()
require "statusline"()
require "treesitter"()
require "format"()
require "lsp"()
require "completion"()

vim.api.nvim_create_autocmd(
    {"VimEnter"},
    {
        callback = function()
            if vim.v.argv[2] == nil then
                require "telescope.builtin".find_files()
            end
        end
    }
)

vim.api.nvim_create_autocmd(
    {"BufWritePost "},
    {
        callback = function()
            vim.cmd("FormatWrite")
        end
    }
)

local options = {
    updatecount = 0,
    number = true,
    ruler = true,
    laststatus = 3,
    signcolumn = "yes",
    hidden = true,
    autochdir = true,
    showmode = false,
    splitright = true,
    splitbelow = true,
    clipboard = "unnamedplus",
    mouse = "a",
    wrap = false,
    conceallevel = 0,
    tabstop = 4,
    scrolloff = 8,
    sidescrolloff = 10,
    shiftwidth = 4,
    smarttab = true,
    expandtab = true,
    smartindent = true,
    autoindent = true,
    updatetime = 200,
    timeoutlen = 400,
    formatoptions = "cro",
    cursorline = true,
    termguicolors = true,
    lazyredraw = true
}

local function autocmds()
    local autocmd = vim.api.nvim_create_autocmd
    autocmd(
        "BufWinEnter",
        {
            pattern = "*",
            callback = function()
                if vim.bo.filetype == "NvimTree" then
                    require "bufferline.state".set_offset(31, "FileTree")
                end
            end
        }
    )

    autocmd(
        "BufWinLeave",
        {
            pattern = "*",
            callback = function()
                if vim.fn.expand("<afile>"):match("NvimTree") then
                    require "bufferline.state".set_offset(0)
                end
            end
        }
    )

    autocmd(
        {"VimEnter"},
        {
            callback = function()
                if vim.v.argv[2] == nil then
                    require "telescope.builtin".find_files()
                end
            end
        }
    )

    autocmd(
        {"BufWritePost "},
        {
            callback = function()
                vim.cmd("FormatWrite")
            end
        }
    )
end

return function()
    for k, v in pairs(options) do
        vim.opt[k] = v
    end

    autocmds()
end

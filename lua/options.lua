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

return function ()
    for k, v in pairs(options) do
        vim.opt[k] = v
    end
end

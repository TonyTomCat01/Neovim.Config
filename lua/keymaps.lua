Opts = {noremap = true, silent = true}

TermOpts = {silent = true}

Keymap = vim.api.nvim_set_keymap

Keymap("", "<Space>", "<Nop>", Opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return function()
    Keymap("n", "<leader>ff", ":Telescope find_files<CR>", Opts)

    Keymap("n", "<leader>;", "<C-w>w", Opts)

    Keymap("n", "<leader>t", ":sp term://fish | resize 8 | setlocal nonumber | setlocal wrap | startinsert <CR>", Opts)
    Keymap("n", "<leader>T", ":vs term://fish | setlocal nonumber | setlocal wrap | startinsert <CR>", Opts)

    Keymap("t", "<Esc>", "<C-\\><C-n>", Opts)

    Keymap("n", "<leader>r", ":!./run<CR>", Opts)
    Keymap("n", "<A-f>", ":NvimTreeToggle", Opts)

    vim.cmd [["augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost * FormatWrite
        augroup END"]]
end

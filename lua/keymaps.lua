Opts = {noremap = true, silent = true}

Keymap = function(a, b, c)
    vim.api.nvim_set_keymap(a, b, c, Opts)
end

Keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return function()
    Keymap("n", "<leader>ff", ":Telescope find_files<CR>")

    Keymap("n", "<leader>;", "<C-w>w")

    Keymap("n", "<leader>t", ":sp term://fish | resize 8 | setlocal nonumber | setlocal wrap | startinsert <CR>")
    Keymap("n", "<leader>T", ":vs term://fish | setlocal nonumber | setlocal wrap | startinsert <CR>")

    Keymap("t", "<Esc>", "<C-\\><C-n>")

    Keymap("n", "<leader>r", ":!./run<CR>")
    Keymap("n", "<A-f>", ":NvimTreeToggle")
end

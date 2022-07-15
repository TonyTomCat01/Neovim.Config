Keymap = function(a, b, c)
    vim.api.nvim_set_keymap(a, b, c, {noremap = true, silent = true})
end


Keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return function()
    Keymap("n", "<leader>ff", ":Telescope find_files<CR>")
    Keymap("n", "<leader>fm", ":Telescope man_pages<CR>")
    Keymap("n", "<leader>fb", ":Telescope buffers<CR>")

    Keymap("n", "<leader>;", "<C-w>w")

    Keymap(
        "n",
        "<leader>t",
        ":sp term://fish | resize 8 | setlocal scrolloff=0 | setlocal nonumber | setlocal wrap | startinsert <CR>"
    )
    Keymap(
        "n",
        "<leader>T",
        ":vs term://fish | setlocal nonumber | setlocal scrolloff=0 | setlocal wrap | startinsert <CR>"
    )

    Keymap("t", "<Esc>", "<C-\\><C-n>")

    Keymap("n", "<leader>r", ":!./run<CR>")
    Keymap("n", "<leader>p", ":!")
    Keymap("n", "<A-f>", ":NvimTreeToggle")

    Keymap("n", "<A-Tab>", ":TabNext")
end

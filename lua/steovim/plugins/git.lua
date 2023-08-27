return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
            vim.keymap.set("n", "<leader>gdd", ":Git difftool -y develop %<CR>", { desc = "Git diff develop" })
            vim.keymap.set("n", "<leader>gdm", ":Git difftool -y main %<CR>", { desc = "Git diff main" })
            vim.keymap.set("n", "<leader>gdh", ":Git difftool -y %<CR>", { desc = "Git diff head" })
            vim.keymap.set("n", "<leader>gdl", ":Git difftool -y %<CR>", { desc = "Git diff head (local)" })
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
}

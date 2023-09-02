return {
    'ggandor/lightspeed.nvim',
    config=function ()
        vim.api.nvim_set_keymap("n", "f", "f", { noremap=true })
        vim.api.nvim_set_keymap("n", "F", "F", { noremap=true })
        vim.api.nvim_set_keymap("n", "t", "t", { noremap=true })
        vim.api.nvim_set_keymap("n", "T", "T", { noremap=true })
    end
}

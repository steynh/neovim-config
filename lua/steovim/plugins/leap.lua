return {
    'ggandor/leap.nvim',
    keys={'<C-f>'},
    config=function ()
        vim.keymap.set('n', '<C-f>', function ()
            require('leap').leap { target_windows = { vim.api.nvim_get_current_win() } }
        end)
        require('leap').opts.safe_labels = {}
    end
}

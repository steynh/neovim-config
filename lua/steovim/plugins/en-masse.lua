return {
    'Olical/vim-enmasse',
    keys = { '<leader>de' },
    config = function()
        require('steovim.config_helpers').set_keymaps({
            prefix = '<leader>',
            { key='de', what='Edit quicklist in-line', how=':EnMasse<CR>'}
        })
    end
}


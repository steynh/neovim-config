return {
    {'junegunn/vim-easy-align'},
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
                border = "rounded"
            }
        },
        hint_enable = false,
    }
}

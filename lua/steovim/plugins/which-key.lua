return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
            for _, v in ipairs(require('steovim.config_helpers').which_key_groups) do
                wk.register(v.map, v.opts)
            end
        end,
    },
}

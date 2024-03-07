-- autocomplete for neovim config (some extra auto config of lua LSP)
if not require('steovim.config').use_new_lsp_and_cmp_config then
    return {
        'folke/neodev.nvim',
        priority = 900,
        config = function()
            require("neodev").setup()
        end
    }
else
    return {}
end

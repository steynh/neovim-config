return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            {'<F8>', ':DapContinue<CR>', desc='Debug Continue'},
            {'<F9>', ':DapStepOver<CR>', desc='Debug Step Over'},
            {'<S-F9>', ':DapStepInto<CR>', desc='Debug Step Into'},
            {'<leader>db', ':DapToggleBreakpoint<CR>', desc='Debug Breakpoint (Toggle)'},
        },
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {'mfussenegger/nvim-dap'},
        config = function ()
            local dapui = require("dapui")
            dapui.setup()
            vim.keymap.set('n', '<leader>dui', dapui.toggle, { desc = 'Debug UI', noremap = true })
        end
    },
    {
        'jbyuki/one-small-step-for-vimkind',
        dependencies = {'mfussenegger/nvim-dap'},
        keys = {
            {'<leader>dn', ':lua require"osv".launch({port = 8086})<CR>', desc = 'Debug this Neovim session'}
        },
        config = function ()
            local dap = require"dap"
            dap.configurations.lua = {
                {
                    type = 'nlua',
                    request = 'attach',
                    name = "Attach to running Neovim instance",
                }
            }

            dap.adapters.nlua = function(callback, config)
                callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
            end
        end
    },
}


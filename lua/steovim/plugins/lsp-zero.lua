local keymaps = require('steovim.keymaps')

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            'eslint',
            'tsserver',
            'clangd',
            'rust_analyzer',
            'jdtls',
            'jsonls',
        })

        lsp.skip_server_setup({ 'jdtls' })

        -- Fix Undefined global 'vim'
        -- lsp.configure('lua-language-server', {
        --     settings = {
        --         Lua = {
        --             diagnostics = {
        --                 globals = { 'vim' }
        --             }
        --         }
        --     }
        -- })

        -- lsp.configure('jsonls', {
        --     settings = {
        --         initializationOptions = {
--      --                capabilities = lsp.defaults.
        --         }
        --     }
        -- })

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-K>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-J>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ["<C-i>"] = cmp.mapping.complete(),
        })

        -- cmp_mappings['<Tab>'] = nil
        -- cmp_mappings['<S-Tab>'] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        lsp.on_attach(function(client, bufnr)
            keymaps.set_lsp_keymaps(bufnr)
        end)


        require('lspconfig').lua_ls.setup({
            -- cmd = {...},
            -- filetypes { ...},
            -- capabilities = {},
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        checkThirdParty = false,
                        -- Tells lua_ls where to find all the Lua files that you have loaded
                        -- for your neovim configuration.
                        library = {
                            '${3rd}/luv/library',
                            '/Users/steyn/g/p/dotfiles/modules/nvim/dot-config/nvim/lua',
                            unpack(vim.fn.glob('/Users/steyn/.local/share/nvim/lazy/*/lua', false, true))
                        },
                        -- If lua_ls is really slow on your computer, you can try this instead:
                        -- library = { vim.env.VIMRUNTIME },
                    },
                    completion = {
                        callSnippet = 'Replace',
                    },
                    -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                    -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        })

        lsp.setup()

        vim.diagnostic.config({
            virtual_text = true
        })
    end
}

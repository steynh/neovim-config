local keymaps = require('steovim.keymaps')

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    cond = not require('steovim.config').use_new_lsp_and_cmp_config,
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

        local luasnip = require('luasnip')
        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = {
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- choose current selection
            ["<C-Space>"] = cmp.mapping.complete(), -- manually trigger cmp menu
            ['<C-l>'] = cmp.mapping(function() -- go to previous area of snippet
                if luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function() -- go to next area of snippet
                if luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { 'i', 's' }),
        }

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

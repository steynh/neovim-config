return { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    cond = require('steovim.config').use_new_lsp_and_cmp_config,
    dependencies = {
        -- Automatically install LSPs and related tools to stdpath for neovim
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
        -- and elegantly composed help section, `:help lsp-vs-treesitter`

        --  This function gets run when an LSP attaches to a particular buffer.
        --    That is to say, every time a new file is opened that is associated with
        --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
        --    function will be executed to configure the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
            callback = function(event)
                require('steovim.keymaps').set_lsp_keymaps(event.buf)
            end,
        })

        -- LSP servers and clients are able to communicate to each other what features they support.
        --  By default, Neovim doesn't support everything that is in the LSP Specification.
        --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
        --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Enable the following language servers
        --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        local servers = {
            -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
            bashls = {},
            clangd = {},
            docker_compose_language_service = {},
            dockerls = {},
            eslint = {},
            gradle_ls = {},
            jsonls = {},
            rust_analyzer = {},
            tsserver = {},
            yamlls = {},
            lua_ls = {
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
                                -- '/Users/steyn/g/p/dotfiles/modules/nvim/dot-config/nvim/lua',
                                unpack(vim.fn.glob('/Users/steyn/.local/share/nvim/lazy/*/lua', false, true)),
                                unpack(vim.api.nvim_get_runtime_file('', true)), -- without this, the global `vim` variable is not available

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
            },
        }

        local other_mason_packages = {
            'stylua', -- Used to format lua code
            'jdtls', -- install but don't config with lsp-zero, config for this is in ftplugin/java.lua
            'beautysh',
            'eslint',
        }

        -- Ensure the servers and tools above are installed
        --  To check the current status of installed tools and/or manually install
        --  other tools, you can run
        --    :Mason
        --
        --  You can press `g?` for help in this menu
        require('mason').setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, other_mason_packages)
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        -- set hooks for starting lsp on buffer attach
        require('mason-lspconfig').setup {
            handlers = {
                function(server_name)
                    -- only configure manually specified servers
                    if servers[server_name] ~= nil then
                        local server = servers[server_name]

                        -- Override capability defaults for specific LSP server
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

                        require('lspconfig')[server_name].setup(server)
                    end
                end,
            },
        }
		require("neodev").setup()
    end,
}

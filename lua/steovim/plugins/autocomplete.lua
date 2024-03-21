if require('steovim.config').use_new_lsp_and_cmp_config then
    return {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        cond = require('steovim.config').use_new_lsp_and_cmp_config,
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    -- This step is not supported in many windows environments
                    -- Remove the below condition to re-enable on windows
                    if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
                dependencies = {
                    'rafamadriz/friendly-snippets' -- community driven collection of snippets (vscode format)
                },
                config = function ()
                end
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds other completion capabilities.
            --  nvim-cmp does not ship with all sources by default. They are split
            --  into multiple repos for maintenance purposes.
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- If you want to add a bunch of pre-configured snippets,
            --    you can use this plugin to help you. It even has snippets
            --    for various frameworks/libraries/etc. but you will have to
            --    set up the ones that are useful for you.
            -- 'rafamadriz/friendly-snippets',
        },
        config = function()
            -- See `:help cmp`
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            -- luasnip.config.setup {}
            require('luasnip.loaders.from_vscode').lazy_load() -- load `friendly-snippets`
            require('steovim.snippets');
            luasnip.config.setup({
                keep_roots = true,
                link_roots = true,
                link_children = true,
                update_events = {"TextChanged", "TextChangedI"},
                enable_autosnippets = true,
            })

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },

                mapping = cmp.mapping.preset.insert {
                    ['<Up>'] = cmp.mapping.select_prev_item(),
                    ['<Down>'] = cmp.mapping.select_next_item(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }, function ()
                        luasnip.expand_or_jump()
                    end), -- choose current selection
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
                },
                sources = {
                    { name = 'buffer' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                },
            }
        end,
    }
else
    return {}
end

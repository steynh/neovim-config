return {
    {
        'ThePrimeagen/harpoon',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            require('harpoon').setup({
                menu = {
                    width = math.min(vim.api.nvim_win_get_width(0) - 10, 180)
                }
            })
            vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, {desc='Harpoon Mark'})
            vim.keymap.set("n", "<leader>n", require("harpoon.ui").toggle_quick_menu, {desc='Harpoon Nark'})

            local harpoon_ui = require('harpoon.ui')
            vim.keymap.set({"n"}, "<C-h>", function () harpoon_ui.nav_file(1) end, {})
            vim.keymap.set({"n"}, "<C-j>", function () harpoon_ui.nav_file(2) end, {})
            vim.keymap.set({"n"}, "<C-k>", function () harpoon_ui.nav_file(3) end, {})
            vim.keymap.set({"n"}, "<C-l>", function () harpoon_ui.nav_file(4) end, {})
            vim.keymap.set({"n"}, "<C-n>", function () harpoon_ui.nav_file(5) end, {})
            --vim.keymap.set({"n", "v", "i"}, "<C-m>", function () harpoon_ui.nav_file(5) end, {})

            require('harpoon.tabline').setup({})
            vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
        end
    },
--     {
--         'alvarosevilla95/luatab.nvim',
--         dependencies={ 'nvim-tree/nvim-web-devicons' },
--         config=function()
--             require('luatab').setup({
-- --                title = function() return '' end,
-- --                modified = function() return '' end,
-- --                windowCount = function() return '' end,
-- --                devicon = function() return '' end,
-- --                separator = function() return '' end,
--             })
--         end
--     }
}

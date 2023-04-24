return {
	'ThePrimeagen/harpoon',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	config = function()
		vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, {desc='Harpoon Mark'})
		vim.keymap.set("n", "<leader>n", require("harpoon.ui").toggle_quick_menu, {desc='Harpoon Nark'})

        local harpoon_ui = require('harpoon.ui')
		vim.keymap.set({"n", "v", "i"}, "<C-j>", function () harpoon_ui.nav_file(1) end, {})
		vim.keymap.set({"n", "v", "i"}, "<C-k>", function () harpoon_ui.nav_file(2) end, {})
		vim.keymap.set({"n", "v", "i"}, "<C-l>", function () harpoon_ui.nav_file(3) end, {})
		vim.keymap.set({"n", "v", "i"}, "<C-n>", function () harpoon_ui.nav_file(4) end, {})
		--vim.keymap.set({"n", "v", "i"}, "<C-m>", function () harpoon_ui.nav_file(5) end, {})
	end
}

return {
	'ThePrimeagen/harpoon',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	config = function()
		vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, {})
		vim.keymap.set("n", "<leader>n", require("harpoon.ui").toggle_quick_menu, {})

        local harpoon_ui = require('harpoon.ui')
		vim.keymap.set("n", "<C-j>", function () harpoon_ui.nav_file(1) end, {})
		vim.keymap.set("n", "<C-k>", function () harpoon_ui.nav_file(2) end, {})
		vim.keymap.set("n", "<C-l>", function () harpoon_ui.nav_file(3) end, {})
		vim.keymap.set("n", "<C-;>", function () harpoon_ui.nav_file(4) end, {})
	end
}

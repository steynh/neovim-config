return {
	'ThePrimeagen/harpoon',
	dependencies = {
		'nvim-lua/plenary.nvim'
	},
	config = function()
		vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file, {})
		vim.keymap.set("n", "<leader>n", require("harpoon.ui").toggle_quick_menu, {})
	end
}

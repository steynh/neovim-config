return {
	'APZelos/blamer.nvim',
	config = function ()
		vim.keymap.set("n", "<leader>cl", ":BlamerToggle<CR>")
	end
}

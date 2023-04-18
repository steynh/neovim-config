vim.g.blamer_date_format = '%y%m%d'
return {
	'APZelos/blamer.nvim',
	config = function ()
		vim.keymap.set("n", "<leader>cl", ":BlamerToggle<CR>")
	end
}

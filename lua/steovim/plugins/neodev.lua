-- autocomplete for neovim config (some extra auto config of lua LSP)
return {
	'folke/neodev.nvim',
	priority = 900,
	config = function()
		require("neodev").setup()
	end
}

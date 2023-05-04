return {
	"folke/tokyonight.nvim",
	lazy = false,  -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
		-- load the colorscheme here
		-- vim.o.background = "dark"

		require("tokyonight").setup({
			style = "storm",
		})
		--vim.cmd([[colorscheme tokyonight]])
		vim.cmd([[colorscheme evening]])
	end,
}

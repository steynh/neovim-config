local function config()
	require('telescope').setup {
		defaults = {
			path_display = { "truncate" },
			follow = true,
		},
		pickers = {
			find_files = {
				follow = true
			}
		}
	}
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>o', builtin.find_files, {})
	vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

	-- vim.keymap.set('n', '<leader>o', function()
	-- 	if pcall(builtin.git_files, { show_untracked = true }) then
	-- 	else
	-- 		builtin.find_files()
	-- 	end
	-- end
	--, {})
end

return {
		-- the colorscheme should be available when starting Neovim
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = config,
}


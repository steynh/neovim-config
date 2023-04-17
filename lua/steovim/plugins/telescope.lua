local function config()
	require('telescope').setup {
		defaults = {
			path_display = { "truncate" },
			file_ignore_patterns = {
				"node_modules/",
				".git/"
			},
		},
		pickers = {
			find_files = {
				follow = true,
				hidden = true
			},
			live_grep = {
				follow = true,
				hidden = true,
				additional_args = function(opts)
					return { "--hidden" }
				end
			}
		}
	}
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>o', builtin.find_files, {})
	vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, {})
	vim.keymap.set('n', '<leader>fp', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

	-- vim.keymap.set('n', '<leader>o', function()
	-- 	if pcall(builtin.git_files, { show_untracked = true }) then
	-- 	else
	-- 		builtin.find_files()
	-- 	end
	-- end
	--, {})

	local function run_command_and_show_output(cmd, title)
		local output = vim.fn.systemlist(cmd)

		if vim.v.shell_error ~= 0 then
			vim.api.nvim_err_writeln('Error running command: ' .. cmd)
			return
		end

		local finders = require('telescope.finders')
		local sorters = require('telescope.sorters')
		local actions = require('telescope.actions')
		local action_state = require('telescope.actions.state')
		local pickers = require('telescope.pickers')

		pickers.new({}, {
			prompt_title = title,
			finder = finders.new_table {
				results = output,
			},
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(_, map)
				map('i', '<CR>', function(prompt_bufnr)
					local selection = action_state.get_selected_entry(prompt_bufnr)
					print(selection.value)
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		}):find()
	end

	local function show_cheatsheet()
		run_command_and_show_output(
		'rg --hidden --trim "vim.keymap" ~/Documents/Workspace/dotfiles/nvim/ | rg --replace "\\$1: \\$2" "^/.*dotfiles/nvim/.config/nvim/lua/steovim/([^:]+):vim.keymap.set\\((.+)\\).*"',
		'Keymap Cheatsheet')
	end

	vim.keymap.set("n", "<leader>cs", show_cheatsheet)
	vim.api.nvim_create_user_command("Cmd", show_cheatsheet, {})
end

return {
	-- the colorscheme should be available when starting Neovim
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = config,
}

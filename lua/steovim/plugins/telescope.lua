local home = os.getenv('HOME')

local function config()
    local telescope = require('telescope')
    telescope.load_extension('harpoon')
	telescope.setup {
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
			},
            lsp_incoming_calls = {
                theme = "cursor",
            },
            lsp_references = {
                theme = "cursor",
            },
		}
	}

	local builtin = require('telescope.builtin')
    require('which-key').register(require('steovim.remap').my_map_format_to_whichkey({
        prefix = '<leader>',
        { key='f',   what='Find (Telescope)'                                                                                                                                                    },
        { key='fw',  what='Find Word under cursor'                                                                                                                                              },
        { key='o',   what='Open file',                                     how=':Telescope find_files<CR>'                                                                                      },
        { key='f/',  what='Find in current file',                          how=':Telescope current_buffer_fuzzy_find<CR>'                                                                       },
        { key='fi',  what='Find Incoming calls',                           how=':Telescope lsp_incoming_calls<CR>'                                                                              },
        { key='fr',  what='Find References',                               how=':Telescope lsp_references<CR>'                                                                                  },
        { key='fp',  what='Find in Project',                               how=':Telescope live_grep<CR>'                                                                                       },
        { key='fb',  what='Find Buffers',                                  how=':Telescope buffers<CR>'                                                                                         },
        { key='fh',  what='Find Help tags',                                how=':Telescope help_tags<CR>'                                                                                       },
        { key='fn',  what='Find Harpoon marks',                            how=':Telescope harpoon marks<CR>'                                                                                   },
        { key='fk',  what='Find Keymaps',                                  how=':Telescope keymaps<CR>'                                                                                         },
        { key='ff',  what='Find Functions',                                how=function() builtin.lsp_document_symbols({symbols={"function", "method"}}) end                                    },
        { key='fg',  what='Find Git files',                                how=function() pcall(builtin.git_files, { show_untracked = true }) end , {}                                          },
        { key='fww', what='Find Word in project',                          how=function() builtin.grep_string({search = vim.fn.expand("<cword>"), follow=true, hidden=true}) end                },
        { key='fwp', what='Find Word in Project',                          how=function() builtin.grep_string({search = vim.fn.expand("<cword>"), follow=true, hidden=true}) end                },
        { key='fwo', what='Find Word Open (find files with word in name)', how=function() builtin.find_files({search_file = vim.fn.expand("<cword>")}) end                                      },
        { key='fwd', what='Find Word in Dev dir',                          how=function() builtin.find_files({search_file = vim.fn.expand("<cword>"), cwd = home .. "/g/dev"}) end              },
        { key='fwf', what='Find Word in global Functions',                 how=function() builtin.lsp_workspace_symbols({query = vim.fn.expand("<cword>"), symbols={"function", "method"}}) end },
        { key='gf',  what='Go Forward',                                    how=function() builtin.find_files({search_file = vim.fn.expand("<cfile>")}) end                                      },
    }))
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
        'nvim-lua/plenary.nvim',
        'ThePrimeagen/harpoon',
        'folke/which-key.nvim',
    },
	config = config,
    keys = { '<leader>o', '<leader>f', '<leader>gf' }
}

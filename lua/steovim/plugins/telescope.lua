local home = os.getenv('HOME')

local function config()
    local telescope = require('telescope')
    telescope.load_extension('harpoon')
    telescope.setup {
        defaults = {
            path_display = { "truncate" },
            file_ignore_patterns = {
                "node_modules/",
                "^%.git/",
                "^(.*/)%.git/",
                "^%.git$",
                "^(.*/)%.git$",
                "%.class$",
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
            -- lsp_incoming_calls = {
            --     theme = "cursor",
            -- },
            -- lsp_references = {
            --     theme = "cursor",
            -- },
        }
    }

    local builtin = require('telescope.builtin')
    require('steovim.config_helpers').set_keymaps({
        prefix = '<leader>',
        { key='f',   what='Find (Telescope)'                                                                                                                                                      },
        { key='fw',  what='Find Word under cursor'                                                                                                                                                },
        { key='o',   what='Open file',                                       how=':Telescope find_files<CR>'                                                                                      },
        { key='f/',  what='Find in current file',                            how=':Telescope current_buffer_fuzzy_find<CR>'                                                                       },
        { key='fp',  what='Find in Project',                                 how=':Telescope live_grep<CR>'                                                                                       },
        { key='fb',  what='Find Buffers',                                    how=':Telescope buffers<CR>'                                                                                         },
        { key='fh',  what='Find Help tags',                                  how=':Telescope help_tags<CR>'                                                                                       },
        { key='fn',  what='Find Harpoon marks',                              how=':Telescope harpoon marks<CR>'                                                                                   },
        { key='fk',  what='Find Keymaps',                                    how=':Telescope keymaps<CR>'                                                                                         },
        { key='fm',  what='Find More (Telescope Resume)',                    how=':Telescope resume<CR>'                                                                                          },
        { key='fg',  what='Find Git files',                                  how=function() pcall(builtin.git_files, { show_untracked = true }) end , {}                                          },
        { mode={'n', 'v'}, key='fww', what='Find exact Word in non-test files of same type', how=function()
            builtin.grep_string({
                word_match="-w",
                follow=true,
                hidden=true,
                additional_args={"--iglob", "!**/test/**", "--iglob", "!**/integrationTest/**", "--type", vim.bo.filetype, "--iglob", "!**/stockholm-automation-clients/**"}
            })
        end                                                                                                                                                                                       },
        { mode={'n', 'v'}, key='fwp', what='Find exact Word in all project files of same type', how=function()
            builtin.grep_string({
                word_match="-w",
                follow=true,
                hidden=true,
                additional_args={"--type", vim.bo.filetype}
            })
        end                                                                                                                                                                                       },
        { key='fwa', what='Find Word in all',                                how=function() builtin.grep_string({search = vim.fn.expand("<cword>"), follow=true, hidden=true}) end                },
        { key='fwo', what='Find Word Open (find files with word in name)',   how=function() builtin.find_files({search_file = vim.fn.expand("<cword>")}) end                                      },
        { key='fwd', what='Find Word in Dev dir',                            how=function() builtin.find_files({search_file = vim.fn.expand("<cword>"), cwd = home .. "/g/dev"}) end              },
        { key='gf',  what='Go Forward',                                      how=function() builtin.find_files({search_file = vim.fn.expand("<cfile>")}) end                                      },
    })
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

return { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        require('mini.surround').setup({
            mappings = {
                add = 's'
            }
        })

        require('mini.comment').setup({
            -- Options which control module behavior
            options = {
                -- Function to compute custom 'commentstring' (optional)
                custom_commentstring = nil,

                -- Whether to ignore blank lines
                ignore_blank_line = false,

                -- Whether to recognize as comment only lines without indent
                start_of_line = false,

                -- Whether to ensure single space pad for comment parts
                pad_comment_parts = true,
            },

            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Toggle comment (like `gcip` - comment inner paragraph) for both
                -- Normal and Visual modes
                comment = 'gk',

                -- Toggle comment on current line
                comment_line = 'gkk',

                -- Toggle comment on visual selection
                comment_visual = 'gk',

                -- Define 'comment' textobject (like `dgc` - delete whole comment block)
                -- Works also in Visual mode if mapping differs from `comment_visual`
                textobject = 'gk',
            },

            -- Hook functions to be executed at certain stage of commenting
            hooks = {
                -- Before successful commenting. Does nothing by default.
                pre = function() end,
                -- After successful commenting. Does nothing by default.
                post = function() end,
            },
        })

        -- Simple and easy statusline.
        --  You could remove this setup call if you don't like it,
        --  and try some other statusline plugin
        local statusline = require 'mini.statusline'
        statusline.setup({
            content = {
                active = function()
                    -- local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
                    local git           = statusline.section_git({ trunc_width = 75 })
                    local diagnostics   = statusline.section_diagnostics({ trunc_width = 75 })
                    local filename      = statusline.section_filename({ trunc_width = 140 })
                    -- local fileinfo      = statusline.section_fileinfo({ trunc_width = 120 })
                    local location      = statusline.section_location({ trunc_width = 75 })
                    local search        = statusline.section_searchcount({ trunc_width = 75 })

                    return statusline.combine_groups({
                        -- { hl = mode_hl,                  strings = { mode } },
                        { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics } },
                        '%<', -- Mark general truncate point
                        { hl = 'MiniStatuslineFilename', strings = { filename } },
                        '%=', -- End left alignment
                        -- { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                        { hl = 'MiniStatuslineFileinfo', strings = { search, location } },
                    })
                end
            }
        })

        -- ... and there is more!
        --  Check out: https://github.com/echasnovski/mini.nvim
    end,
}


require("steovim.lazy")
require("steovim.remap")
require("steovim.set")
require("steovim.config_helpers")

vim.filetype.add({
    pattern = {
        ['.*'] = {
            priority=-math.huge,
            function(_, bufnr)
                local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
                if (first_line == "#!/usr/bin/env zx") then
                    return 'javascript'
                end
                return nil
            end
        }
    },
})


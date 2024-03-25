vim.keymap.set("n", "<leader>rr", function ()
    vim.api.nvim_command('write')
    require('overseer').open({enter=false, direction='bottom'})
    vim.cmd('OverseerRunCmd cargo run')
end, {buffer = true})


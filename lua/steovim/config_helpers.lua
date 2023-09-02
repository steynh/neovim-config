local M = {}

M.which_key_groups = {}

-- Example: 
-- {
--     prefix = '<leader>',
--     { key = 'f', what = 'Find (Telescope)' },
--     { key = 'fp', what = 'Find in Project files', how = ':Telescope live_grep' },
-- }
function M.set_keymaps(map, opts)
    map = map or {}
    opts = opts or {}
    local prefix = map.prefix or ''

    for _, v in ipairs(map) do
        assert(v.key, 'missing `key` in keymap entry')
        assert(v.what, 'missing `what` in keymap entry')
        local key = prefix .. v.key
        if (v.how) then
            vim.keymap.set(
                v.mode or "n", key, v.how,
                {
                    desc = v.what,
                    noremap = v.noremap or map.noremap or true,
                    buffer = opts.buffer or nil
                })
        else
            -- this is not a complete keymap, but a group description for which-key.nvim
            table.insert(M.which_key_groups, {
                map = { [key] = { name = v.what } },
                opts = { buffer = opts.buffer, mode = v.mode }
            })
        end
    end
end

return M

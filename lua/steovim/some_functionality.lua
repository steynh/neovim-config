local M = {}

vim.api.nvim_create_user_command("AlignKeymaps", function ()
    vim.cmd("'<,'>EasyAlign /mode=/")
    vim.cmd("'<,'>EasyAlign /key=/")
    vim.cmd("'<,'>EasyAlign /what=/")
    vim.cmd("'<,'>EasyAlign /how=/")
    vim.cmd("'<,'>EasyAlign /},$/")
end, {range=true})

function M.toggle_lsp_highlight()
    vim.lsp.buf.clear_references()
    vim.cmd([[
        if !exists('#lsp_highlight#CursorHold')
            augroup lsp_highlight
                autocmd!
                autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        else
            augroup lsp_highlight
                autocmd!
            augroup END
        endif
    ]])
end

function M.substitute_in_block(substitutions, start_pos, end_pos)
    for line = start_pos, end_pos do
        local currentLine = vim.fn.getline(line)

        for _, subst in ipairs(substitutions) do
            local pattern, replacement, flags = unpack(subst)
            currentLine = vim.fn.substitute(currentLine, pattern, replacement, flags)
        end

        vim.fn.setline(line, currentLine)
    end
end

function M.java_to_multiline_string(start_pos, end_pos)
    print('s' .. start_pos .. 'e' .. end_pos)
    M.substitute_in_block({
        {'res', 'yooooooooooooooo', ''},
        {'^"', '', ''},
        {'\n" +', '', ''},
        {'\\"', '"', 'g'}
    }, start_pos, end_pos)
end

-- better highlight and search
vim.keymap.set("n", "*", "*``", {})
vim.on_key(function(key)
  if vim.fn.mode() == "n" then
      local char = vim.fn.keytrans(key)
      local current_hlsearch = vim.opt.hlsearch:get()
      local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, char) or current_hlsearch and char == '`'
      if current_hlsearch ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")

vim.api.nvim_create_user_command("CodeNotes", function(opts)
    local subcommand = opts.args
    local path = vim.fn.expand('%:p')

    local cmd
    if (opts.range == 2) then
        cmd = string.format('code-notes "%s" %s %s %s | pbcopy', path, opts.line1, opts.line2, subcommand)
    else
        cmd = string.format('code-notes "%s" %s | pbcopy', path, subcommand)
    end
    print(vim.fn.system(cmd))
end, { range=true, nargs='*' })

vim.api.nvim_set_keymap('v', '<leader>cn', ':CodeNotes render-template --with-ref-note --create obsidian', { desc='Copy Note snippet (code-notes)' })
vim.api.nvim_set_keymap('v', '<leader>cs', ':CodeNotes render-template slack', { desc='Copy Slack snippet (code-notes)' })
vim.api.nvim_set_keymap('v', '<leader>cp', ':CodeNotes permalink', { desc='Copy Permalink (code-notes)' })
vim.api.nvim_set_keymap('n', '<leader>co', ':!open "obsidian://$(code-notes "%" ref-note-path --create --debug)"<CR>', { desc='Code-notes Open in obsidian' })

vim.api.nvim_create_user_command("JavaMultiLine", function(opts)
    if (opts.range == 2) then
        print("yo WTF")
        M.java_to_multiline_string(opts.line1, opts.line2)
    else
        print("yo wtf")
    end
end, { range=true, nargs='*' })

local function get_visual_block_range()
    vim.cmd("norm y")
    return {
        first_line = vim.fn.getpos("'<")[2],
        last_line = vim.fn.getpos("'>")[2],
    }
end

local function run_code_notes_for_visual_block(subcommand)
    local v = get_visual_block_range()
    local path = vim.fn.expand('%:p')
    local cmd = string.format('code-notes "%s" %s %s %s | pbcopy', path, v.first_line, v.last_line, subcommand)
    local out = vim.fn.system(cmd)
    if (out ~= '') then
        error(out)
    end
    if (vim.v.shell_error ~= 0) then
        print(out)
        vim.cmd('messages')
    end
end

function M.copy_obsidian_code_ref_snippet()
    run_code_notes_for_visual_block('render-template --with-ref --create obsidian')
end

function M.copy_slack_snippet()
    run_code_notes_for_visual_block('render-template slack')
end

function M.copy_github_permalink_for_visual_block()
    run_code_notes_for_visual_block('permalink')
end

return M

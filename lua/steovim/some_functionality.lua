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

return M

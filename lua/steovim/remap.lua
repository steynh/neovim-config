vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>h", "<C-w>h", {desc="Go To Left Pane"})
vim.keymap.set("n", "<leader>j", "<C-w>j", {desc="Go To Down Pane"})
vim.keymap.set("n", "<leader>k", "<C-w>k", {desc="Go To Up Pane"})
vim.keymap.set("n", "<leader>l", "<C-w>l", {desc="Go To Right Pane"})
vim.keymap.set("n", "<leader>grs", ":s/^\\w\\+ /squash /<CR>")
vim.keymap.set("n", "<leader>grf", ":s/^\\w\\+ /fixup /<CR>")
-- vim.keymap.set("n", ";", ":")
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>tlf", ":%s/^.* 1: //<CR>")
vim.keymap.set("n", "<leader>vrm", ":so ~/.config/nvim/lua/steovim/remap.lua<CR>", {desc="Vim Re-Map (source remap.lua)"})
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>")

vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")


vim.keymap.set("n", "<leader>vlr", function() vim.opt.relativenumber = true end, {desc="Vim Line number Relative"})
vim.keymap.set("n", "<leader>vla", function() vim.opt.relativenumber = false end, {desc="Vim Line number Absolute"})

local function set_lsp_keymaps(bufnr)
    local function opts(extra)
        local result = { buffer = bufnr, remap = false }
        for k, v in pairs(extra) do
            result[k] = v
        end
        return result
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts({desc="Goto Definition"}))
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts({desc="Goto Implementation"}))
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts({}))
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol('') end, opts({desc="Vim Workspace Symbol"}))
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts({desc="Vim Diagnostic"}))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts({}))
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({}) end, opts({}))
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts({desc="Vim Code Action"}))
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts({desc="Vim RefeRences"}))
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts({desc="Vim ReName"}))
    vim.keymap.set("n", "<leader>vfm", function() vim.lsp.buf.format() end, opts({desc="Vim ForMat"}))
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts({}))

    vim.keymap.set({"n", "i"}, "<C-p>", function() vim.lsp.buf.signature_help() end, opts)
end

-- better highlight and search
vim.keymap.set("n", "*", "*``", {})
vim.on_key(function(key)
  if vim.fn.mode() == "n" then
      local char = vim.fn.keytrans(key)
      local current_hlsearch = vim.opt.hlsearch:get()
      local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, char) or current_hlsearch == false and char == '`'
      if current_hlsearch ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")


return {
    set_lsp_keymaps = set_lsp_keymaps
}

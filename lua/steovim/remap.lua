vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>h", "<C-w>h", {desc="Go To Left Pane"})
vim.keymap.set("n", "<leader>j", "<C-w>j", {desc="Go To Down Pane"})
vim.keymap.set("n", "<leader>k", "<C-w>k", {desc="Go To Up Pane"})
vim.keymap.set("n", "<leader>l", "<C-w>l", {desc="Go To Right Pane"})
vim.keymap.set("n", "<leader>grs", ":s/^\\w\\+ /squash /<CR>")
vim.keymap.set("n", "<leader>grf", ":s/^\\w\\+ /fixup /<CR>")
-- vim.keymap.set("n", ";", ":")
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>gs", ":s/^pick/squash/<CR>")
vim.keymap.set("n", "<leader>tlf", ":%s/^.* 1: //<CR>")
vim.keymap.set("n", "<leader>vrm", ":so ~/.config/nvim/lua/steovim/remap.lua")

vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")

local function set_lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol('') end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({}) end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vs", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<C-p>ws", function() vim.lsp.buf.workspace_symbol('') end, opts)
    vim.keymap.set("n", "<C-p>d", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<C-p>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<C-p>rr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<C-p>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-p>p", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<C-p>p", function() vim.lsp.buf.signature_help() end, opts)
end

return {
    set_lsp_keymaps = set_lsp_keymaps
}

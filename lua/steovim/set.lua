-- vim.opt.guicursor = ""

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth=4
vim.opt.smarttab = true
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2,min:40,sbr"
vim.opt.expandtab = true
vim.opt.listchars="tab: |"
vim.cmd("set invlist")

vim.opt.smartindent = true

--vim.opt.wrap = false

vim.opt.swapfile = false
--vim.opt.backup = false
--vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
--vim.opt.undofile = true

vim.opt.autoread = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.cursorline = true

-- vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "auto:3-4" -- git, mark, diagnostic, extra
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.shell = "/bin/bash"

-- vim.opt.colorcolumn = "80"

-- don't continue comments when typing `o` or `O` in normal mode
vim.api.nvim_create_autocmd({'FileType'}, {
    group=vim.api.nvim_create_augroup('formatoptions', {clear=true}),
    pattern='*',
    callback=function() vim.opt.formatoptions:remove('o') end
})

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- enable border for LSP hover buffers
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "single"
  }
)
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
--   vim.lsp.handlers.signature_help, {
--     border = "double"
--   }
-- )

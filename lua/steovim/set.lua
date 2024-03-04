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

-- vim.opt.colorcolumn = "80"

-- don't continue comments when typing `o` or `O` in normal mode
vim.api.nvim_create_autocmd({'FileType'}, {
    group=vim.api.nvim_create_augroup('formatoptions', {clear=true}),
    pattern='*',
    callback=function() vim.opt.formatoptions:remove('o') end
})


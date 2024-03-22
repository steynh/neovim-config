local fn = require('steovim.some_functionality')

local leader_keymap = {
    prefix = '<leader>',

    {                   key= 'pv',  what= 'Project View',                         how= function() vim.cmd.Ex() end                                                                                                  },
    {                   key= 'h',   what= 'Go To Left Pane',                      how= '<C-w>h'                                                                                                                     },
    {                   key= 'j',   what= 'Go To Down Pane',                      how= '<C-w>j'                                                                                                                     },
    {                   key= 'k',   what= 'Go To Up Pane',                        how= '<C-w>k'                                                                                                                     },
    {                   key= 'l',   what= 'Go To Right Pane',                     how= '<C-w>l'                                                                                                                     },
    {                   key= 'vrm', what= 'Vim Re-Map (source keymaps.lua)',      how= ':so ~/.config/nvim/lua/steovim/keymaps.lua<CR>'                                                                             },
    {                   key= 'tc',  what= 'Tab Close',                            how= ':tabclose<CR>'                                                                                                              },
    {                   key= 'tn',  what= 'Tab Next',                             how= ':tabnext<CR>'                                                                                                              },
    { mode = 'v',       key= 'p',   what= 'Paste without overriding buffer',      how= [["_dP]]                                                                                                                     },
    { mode= {'n', 'v'}, key= 'y',   what= 'Yank to clipboard',                    how= '"+y'                                                                                                                        },
    { mode= {'n', 'v'}, key= 'd',   what= 'Delete to clipboard',                  how= '"+d'                                                                                                                        },

    {                   key= 's',   what= 'Set'                                                                                                                                                                     },
    {                   key= 'slr', what= 'Vim Line number Relative',             how= function() vim.opt.relativenumber = true end                                                                                 },
    {                   key= 'sla', what= 'Vim Line number Absolute',             how= function() vim.opt.relativenumber = false end                                                                                },
    {                   key= 'sfj', what= 'Set Filetype JSON',                    how= ':set filetype=json<CR>'                                                                                                     },

    { mode= {'n', 'v'}, key= 'c',   what= 'Code-notes'                                                                                                                                                              },
    {                   key= 'cc',  what= 'Code-notes Create ref-note',           how= ':CodeNotes ref-note-path --create --debug<CR>'                                                                              },
    {                   key= 'co',  what= 'Code-notes Open in obsidian',          how= ':!open "obsidian://$(code-notes "%" ref-note-path --create --debug)"<CR>'                                                   },
    { mode= 'v',        key= 'cn',  what= 'Copy Note snippet (code-notes)',       how= ':CodeNotes render-template --with-ref-note --create obsidian<CR>'                                                           },
    { mode= 'v',        key= 'cs',  what= 'Copy Slack snippet (code-notes)',      how= ':CodeNotes render-template slack<CR>'                                                                                       },
    { mode= {'n', 'v'}, key= 'cp',  what= 'Copy Permalink (code-notes)',          how= ':CodeNotes permalink<CR>'                                                                                                   },
    {                   key= 'crp', what= 'Copy file Relative Path',              how= ':!echo -n "%" | pbcopy<CR>'                                                                                                 },
    {                   key= 'cf',  what= 'Copy File name',                       how= ':!basename "%" | tr -d "\\n" | pbcopy<CR>'                                                                                  },


    {                   key= 'bd',  what= 'Buffer Delete',                        how= ':silent! bp | sp | silent! bn | bd<CR>'                                                                                     },

    {                   key= 'rdd',  what= '[Runner] Dispose current task',       how= ':OverseerQuickAction dispose<CR>'                                                                                           },
    {                   key= 'rda',  what= '[Runner] Dispose All tasks',          how= ':OverseerDisposeAllTasks<CR>'                                                                                           },

    { mode= 'v',        key= 'jmm', what= 'Java to Multiline',                    how= ':JavaMultiLine<CR>'                                                                                                         },
}

local no_prefix_keymap = {

 -- { mode= {'n', 'v', 'i'}, key= '<C-s>', what= '',                         how= '<Esc>:w<CR>'            },
    { mode= 'n',             key= 'L',     what= '',                         how= '$'                      },
    { mode= 'n',             key= 'H',     what= '',                         how= '^'                      },
    { mode= {'o', 'x'},      key="iF",     what= 'Inner File (text object)', how= ":<c-u>normal! ggVG<cr>" },
    { mode= {'n', 'i', 'c'}, key="<C-p>",  what= '',                         how= "<Up>"                   },
    { mode= {'n', 'i', 'c'}, key="<C-n>",  what= '',                         how= "<Down>"                   },
}

local ts = require('telescope.builtin')

local lsp_keymaps = {
    {
        {                   key= "gd",    what= 'desc="Goto Definition"',       how= ts.lsp_definitions },
        {                   key= "gi",    what= 'desc="Goto Implementation"',   how= ts.lsp_implementations },

        {                   key= 'K',     what= '',                             how= vim.lsp.buf.hover },
        {                   key= ']d',    what= '',                             how= vim.diagnostic.goto_next },
        {                   key= '[d',    what= '',                             how= vim.diagnostic.goto_prev },
        { mode= {'n', 'i'}, key= '<C-s>', what= '',                             how= require('lsp_signature').toggle_float_win },
        {                   key='ff',     what='Find Functions',                how= function() ts.lsp_document_symbols({symbols={"function", "method"}}) end },
        {                   key='fwf',    what='Find Word in global Functions', how= function() ts.lsp_workspace_symbols({query = vim.fn.expand("<cword>"), symbols={"function", "method"}}) end },
        {                   key='fi',     what='Find Incoming calls',           how=':Telescope lsp_incoming_calls<CR>' },
        {                   key='fr',     what='Find References',               how=':Telescope lsp_references<CR>' },
    },
    {
        prefix='<leader>',
        {                   key= 'K',     what= '',                             how= vim.lsp.buf.signature_help },
        {                   key= "vws",   what= 'Vim Workspace Symbol',         how= function() vim.lsp.buf.workspace_symbol('') end },
        {                   key= "id",    what= 'Intelli Diagnostic',           how= function() vim.diagnostic.open_float() end },
        {                   key= "ia",    what= 'Intelli Action',               how= function() vim.lsp.buf.code_action() end },
        {                   key= "irr",   what= 'Intelli RefeRences',           how= function() vim.lsp.buf.references() end },
        {                   key= "irn",   what= 'Intelli ReName',               how= function() vim.lsp.buf.rename() end },
        {                   key= "if",    what= 'Intelli Format',               how= function() vim.lsp.buf.format() end },
        {                   key= "ih",    what= 'Intelli HighLight (toggle)',   how= function() fn.toggle_lsp_highlight() end },
    }
}

local config_helpers = require('steovim.config_helpers')
config_helpers.set_keymaps(leader_keymap)
config_helpers.set_keymaps(no_prefix_keymap)

local M = {}
function M.set_lsp_keymaps(bufnr)
    for _, keymap in ipairs(lsp_keymaps) do
        config_helpers.set_keymaps(keymap, { buffer=bufnr })
    end
end

return M

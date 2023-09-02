local fn = require('steovim.some_functionality')

local leader_keymap = {
    prefix = '<leader>',

    {                   key= 'pv',  what= 'Project View',                           how= function() vim.cmd.Ex() end                           },
    {                   key= 'h',   what= 'Go To Left Pane',                        how= '<C-w>h'                                              },
    {                   key= 'j',   what= 'Go To Down Pane',                        how= '<C-w>j'                                              },
    {                   key= 'k',   what= 'Go To Up Pane',                          how= '<C-w>k'                                              },
    {                   key= 'l',   what= 'Go To Right Pane',                       how= '<C-w>l'                                              },
    {                   key= 'vrm', what= 'Vim Re-Map (source remap.lua)',          how= ':so ~/.config/nvim/lua/steovim/remap.lua<CR>'        },
    {                   key= 'tc',  what= 'Tab Close',                              how= ':tabclose<CR>'                                       },
    {                   key= 'p',   what= 'Paste without overriding buffer',        how= [["_dP]]                                              },
    { mode= {'n', 'v'}, key= 'y',   what= 'Yank to clipboard',                      how= '"+y'                                                 },
    { mode= {'n', 'v'}, key= 'd',   what= 'Delete to clipboard',                    how= '"+d'                                                 },
    {                   key= 'yp',  what= 'Yank file Path to clipboard',            how= ':!echo -n "%" | pbcopy<CR>'                          },
    {                   key= 'yg',  what= 'Yank blob link to clipboard',            how= ':!get-blob-link "%:p" | pbcopy<CR>'                  },
    {                   key= 'grs', what= 'Git Rebase Squash',                      how= ':s/^\\w\\+ /squash /<CR>'                            },
    {                   key= 'grf', what= 'Git Rebase Fixup',                       how= ':s/^\\w\\+ /fixup /<CR>'                             },

    {                   key= 's',   what= 'Set'                                                                                                },
    {                   key= 'slr', what= 'Vim Line number Relative',               how= function() vim.opt.relativenumber = true end          },
    {                   key= 'sla', what= 'Vim Line number Absolute',               how= function() vim.opt.relativenumber = false end         },
    {                   key= 'sfj', what= 'Set Filetype JSON',                      how= ':set filetype=json<CR>'                              },

    { mode= {'n', 'v'}, key= 'c',   what= 'Code-notes'                                                                                         },
    {                   key= 'cr',  what= 'Code-notes create Ref-file',             how= ':!code-notes "%" ref-file --create<CR>'              },
    {                   key= 'cn',  what= 'Code-notes create Note',                 how= ':!code-notes "%" code-snippet --create | pbcopy<CR>' },
    { mode= 'v',        key= 'cyp', what= 'Code-notes Yank Permalink to clipboard', how= fn.get_github_permalink_for_visual_block              },
}

local no_prefix_keymap = {

    { mode= {'n', 'v', 'i'}, key= '<C-s>', what= '',                                how= '<Esc>:w<CR>'                                  },
    { mode= 'n',             key= 'L',     what= '',                                how= '$'                                            },
    { mode= 'n',             key= 'H',     what= '',                                how= '^'                                            },

}

local lsp_keymaps = {
    {
        {                   key= "gd",    what= 'desc="Goto Definition"',     how= function()    vim.lsp.buf.definition()            end },
        {                   key= "gi",    what= 'desc="Goto Implementation"', how= function()    vim.lsp.buf.implementation()        end },
        {                   key= "K",     what= '',                           how= function()    vim.lsp.buf.hover()                 end },
        {                   key= "]d",    what= '',                           how= function()    vim.diagnostic.goto_next()          end },
        {                   key= "[d",    what= '',                           how= function()    vim.diagnostic.goto_prev({})        end },
        { mode= "i",        key= "<C-h>", what= '',                           how= function()    vim.lsp.buf.signature_help()        end },
        { mode= {"n", "i"}, key= "<C-p>", what= '',                           how= function()    vim.lsp.buf.signature_help()        end },
    },
    {
        prefix='<leader>',
        {                   key= "gd",    what= "Don't Goto Definition",      how= function()    print_definition_positions()        end },
        {                   key= "vws",   what= 'Vim Workspace Symbol',       how= function()    vim.lsp.buf.workspace_symbol('')    end },
        {                   key= "vd",    what= 'Vim Diagnostic',             how= function()    vim.diagnostic.open_float()         end },
        {                   key= "vca",   what= 'Vim Code Action',            how= function()    vim.lsp.buf.code_action()           end },
        {                   key= "vrr",   what= 'Vim RefeRences',             how= function()    vim.lsp.buf.references()            end },
        {                   key= "vrn",   what= 'Vim ReName',                 how= function()    vim.lsp.buf.rename()                end },
        {                   key= "vfm",   what= 'Vim ForMat',                 how= function()    vim.lsp.buf.format()                end },
        {                   key= "vhl",   what= 'Vim HighLight',              how= function()    fn.toggle_lsp_highlight()           end },
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

local root_markers = {'gradlew', '.git'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse-2/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local config_dir = home .. "/.local/share/nvim/mason/packages/jdtls/config_mac"

local config = {
    cmd = {
        'jdtls',
        '-configuration', config_dir,
        '-data', workspace_folder,
    },
    root_dir=root_dir,
    on_attach=function (_, bufnr)
        require('steovim.remap').set_lsp_keymaps(bufnr)
    end,
    settings = {
        java = {
            autobuild = { enabled = false },
            import = {
                gradle = {
                    enabled = true,
                }
            }
        },
    },
}
require('jdtls').start_or_attach(config)

-- example: https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L1-L149


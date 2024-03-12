local jdtls = require('jdtls')
local home = os.getenv('HOME')
local config_dir = home .. "/.local/share/nvim/mason/packages/jdtls/config_mac"

local root_markers = {'gradlew', '.git'}
local root = require('jdtls.setup').find_root(root_markers)
local workspace_folder = nil
local root_dir = nil
if root ~= nil then 
    root_dir = vim.fn.expand(root)
    local parent_dir = vim.fn.expand("~/g/")
    if parent_dir:sub(-1) ~= "/" then
        parent_dir = parent_dir .. "/"
    end
    -- Use string.gsub to replace the parent directory part in the file path with nothing
    local relative_path = root_dir:gsub("^" .. parent_dir, "")
    workspace_folder = home .. "/.local/share/eclipse/" .. relative_path
end


local java = "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/bin/java"

local cmd_java = {
    java,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/packages/jdtls/plugins/lombok.jar',
    --'-Xbootclasspath/a:' .. home .. '/.local/share/nvim/mason/packages/jdtls/plugins/lombok.jar',
    '-jar', vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', config_dir,
    '-data', workspace_folder,
}

local cmd_jdtls = {
    'jdtls',
    '-configuration', config_dir,
    '-data', workspace_folder,
    '-Xmx2g'
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   },
-- }

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
-- extendedClientCapabilities.classFileContentsSupport = true;
-- extendedClientCapabilities.generateToStringPromptSupport = true;
-- extendedClientCapabilities.hashCodeEqualsPromptSupport = true;
-- extendedClientCapabilities.advancedExtractRefactoringSupport = false;
-- extendedClientCapabilities.advancedOrganizeImportsSupport = false;
-- extendedClientCapabilities.generateConstructorsPromptSupport = false;
-- extendedClientCapabilities.generateDelegateMethodsPromptSupport = false;
-- extendedClientCapabilities.moveRefactoringSupport = false;
-- extendedClientCapabilities.overrideMethodsPromptSupport = false;
-- extendedClientCapabilities.executeClientCommandSupport = false;

local config = {
    cmd = cmd_java,
    root_dir=root_dir,
    on_attach=function (_, bufnr)
        if not require('steovim.config').use_new_lsp_and_cmp_config then
            require('steovim.keymaps').set_lsp_keymaps(bufnr)
        end
    end,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            autobuild = { enabled = false },
            import = {
                gradle = {
                    enabled = true,
                    offline = { enabled = true },
                    wrapper = {
                        enabled = true,
                    }
                }
            },
            codeGeneration = {
                useBlocks = true,
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/Library/Java/JavaVirtualMachines/applejdk-17.jdk/Contents/Home/",
                    },

                }
            }
        },
    },
    capabilities = capabilities,
    extendedClientCapabilities = extendedClientCapabilities
}

print("Attaching jdtls")
require('jdtls').start_or_attach(config)

-- example: https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/ftplugin/java.lua#L1-L149


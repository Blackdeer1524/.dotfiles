local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify("JDTLS not found, install with `:LspInstall jdtls`")
    return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

-- https://download.eclipse.org/jdtls/milestones/
-- place installed jdtls into home/%USERNAME% directory
local jdtls_path = vim.fn.expand("$HOME") .. "/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_linux"
local path_to_plugins = jdtls_path .. "/plugins"
local path_to_jar = path_to_plugins .. "/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"

-- https://projectlombok.org/download
-- place lombok into plugins directory
local lombok_path = path_to_plugins .. "/lombok.jar"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
    vim.notify("Java root dir not found", 4)
    return
end
--
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
os.execute("mkdir -p " .. workspace_dir)

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.offsetEncoding = { "utf-32" }
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Main Config
--
--
-- Install open-jdk-17
-- sudo apt install openjdk-17-jdk openjdk-17-jre
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line

    capabilities = capabilities,
    cmd = {
        '/usr/bin/java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. lombok_path,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-jar', path_to_jar,
        '-configuration', path_to_lsp_server,
        '-data', workspace_dir,
    },
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    root_dir = root_dir,
    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            home = '/usr/lib/jvm/java-17-openjdk-amd64',
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk-amd64/",
                    },
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            -- format = {
            --     enabled = true,
            --     settings = {
            --         url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
            --         profile = "GoogleStyle",
            --     },
            -- },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        -- DEBUG
        -- https://github.com/microsoft/java-debug
        -- apperenty installation only works with Java 17 (only tried Java 19, but on this version it throws errors)
        bundles = {
            vim.fn.glob(
                vim.fn.expand("$HOME") ..
                "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
                1)
        },
    }
}

local default_on_attach = require("lsp/defaults").on_attach
config['on_attach'] = function(client, bufnr)
    -- You need java 17 to be able to install java-debug!!!
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    default_on_attach(client, bufnr)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
vim.cmd(
    "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

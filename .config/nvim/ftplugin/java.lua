local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    vim.notify("JDTLS not found, install with `:LspInstall jdtls`")
    return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

-- place installed jdtls into home/%USERNAME% directory
local jdtls_path = require("lsp.defaults").MASON_PACKAGES .. "/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_linux"
local path_to_plugins = jdtls_path .. "/plugins"
local path_to_jar = vim.split(
    vim.fn.glob(path_to_plugins .. "/org.eclipse.equinox.launcher_*.jar"),
    "\n")[1]

-- place lombok into plugins directory
local lombok_path = jdtls_path .. "/lombok.jar"

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
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- Main Config

-- Install open-jdk-17
-- sudo apt install openjdk-17-jdk openjdk-17-jre
local config = {
    -- The command that starts the language server
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
    -- for a list of options
    settings = {
        java = {
            home = '/usr/lib/jvm/java-21-openjdk-amd64',
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
                    {
                        name = "JavaSE-21",
                        path = "/usr/lib/jvm/java-21-openjdk-amd64/",
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
    }
}

local default_on_attach = require("lsp.defaults").on_attach
config['on_attach'] = function(client, bufnr)
    -- You need java 17 to be able to install java-debug!!!
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls.dap").setup_dap_main_class_configs()
    default_on_attach(client, bufnr)
end

-- DEBUG
local bundles = {
    vim.fn.glob(
        require("lsp.defaults").MASON_PACKAGES ..
        "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
        1)
}

-- This is the new part
vim.list_extend(bundles,
    vim.split(
        vim.fn.glob(
            require("lsp.defaults").MASON_PACKAGES .. "/java-test/extension/server/*.jar", 1),
        "\n")
)
config['init_options'] = {
    bundles = bundles,
}


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

vim.cmd("command! -buffer JdtTestClass lua require'jdtls'.test_class()")
vim.cmd("command! -buffer JdtTestNearestMethod lua require('jdtls').test_nearest_method()")

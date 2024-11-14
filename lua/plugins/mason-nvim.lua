local global = require("config.global")

---@type boolean
local need_all_servers = require("config.settings").need_all_servers

---@type LazySpec
local spec = {
    "williamboman/mason.nvim",
    --lazy = false,
    cmds = require("plugins.configs.mason-nvim.cmds"),
    event = "VeryLazy",
    dependencies = require("plugins.configs.mason-nvim.dependencies"),
    config = function()
        local lspconfig = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_nvim_dap = require("mason-nvim-dap")

        require("neoconf").setup({})
        require("mason").setup({
            max_concurrent_installers = global.is_human_rights and 4 or 1,
            ui = {
                check_outdated_packages_on_open = true,
                border = "rounded",
                width = 0.88,
                height = 0.8,
                icons = {
                    package_installed = "󰗠",
                    package_pending = "󰊠",
                    package_uninstalled = "󰅙",
                },
            },
            log_level = vim.log.levels.DEBUG,
        })

        -- LSP
        mason_lspconfig.setup({
            ensure_installed = require("plugins.configs.mason-lspconfig.ensure_installed"),
        })

        mason_lspconfig.setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                })
            end,
            ["rust_analyzer"] = function() end,
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup(require("plugins.configs.lspconfigs.lua-ls"))
            end,
            ["jsonls"] = function()
                lspconfig.jsonls.setup(require("plugins.configs.lspconfigs.jsonls"))
            end,
            ["yamlls"] = function()
                lspconfig.yamlls.setup(require("plugins.configs.lspconfigs.yamlls"))
            end,
        })

        lspconfig.bashls.setup({})
        lspconfig.cssls.setup({})
        lspconfig.denols.setup({})
        lspconfig.docker_compose_language_service.setup({})
        lspconfig.dockerls.setup({})
        lspconfig.eslint.setup({})
        lspconfig.html.setup({})
        lspconfig.jsonls.setup({})
        lspconfig.lua_ls.setup({})
        lspconfig.luau_lsp.setup({})
        lspconfig.marksman.setup({})
        lspconfig.powershell_es.setup({})
        lspconfig.pyright.setup({})
        lspconfig.taplo.setup({})
        lspconfig.ts_ls.setup({})
        lspconfig.typos_lsp.setup({})
        lspconfig.vimls.setup({})
        lspconfig.yamlls.setup({})
        if not global.is_windows then
            lspconfig.markdown_oxide.setup({})
            if need_all_servers then
                lspconfig.csharp_ls.setup({})
                lspconfig.esbonio.setup({})
                lspconfig.gopls.setup({})
                lspconfig.jqls.setup({})
                lspconfig.nil_ls.setup({})
                lspconfig.solargraph.setup({})
            end
        end
        if need_all_servers then
            lspconfig.clangd.setup({})
            lspconfig.efm.setup({})
            lspconfig.graphql.setup({})
            lspconfig.neocmake.setup({})
            lspconfig.zls.setup({})
        end

        -- All-in-one Linter, Formatter
        require("mason-null-ls").setup({
            handlers = {},
        })

        -- DAP
        mason_nvim_dap.setup({
            ensure_installed = require("plugins.configs.mason-nvim-dap.ensure_installed"),
            handlers = {
                function(config)
                    mason_nvim_dap.default_setup(config)
                end,
            },
        })

        -- Utils
        require("mason-lock").setup({
            lockfile_path = global.mason_lockfile,
        })
    end,
    --cond = false,
    --enabled = false,
}

return spec

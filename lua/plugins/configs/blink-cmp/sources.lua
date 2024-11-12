local global = require("config.global")

---@type table
local enabled_providers = {
    "lsp",
    "path",
    "snippets",
    "buffer",
    "lazydev",
    "emoji",
    "copilot",
}

local sources = {
    completion = {
        enabled_providers = enabled_providers,
    },
    providers = {
        lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            enabled = true,
            fallback_for = { "lazydev" },
            score_offset = 0,
        },
        path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            enabled = true,
            score_offset = 3,
            opts = {
                trailing_slash = false,
                label_trailing_slash = true,
                get_cwd = function(context)
                    return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
                end,
                show_hidden_files_by_default = false,
            },
        },
        snippets = {
            name = "Snippets",
            module = "blink.cmp.sources.snippets",
            enabled = function(ctx)
                return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
            end,
            score_offset = -3,
            opts = {
                friendly_snippets = true,
                search_paths = { global.snippets_dir },
                global_snippets = { "all" },
                extended_filetypes = {},
                ignored_filetypes = {},
            },
        },
        buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            enabled = true,
            fallback_for = { "lsp" },
            score_offset = 0,
        },
        lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            enabled = true,
            score_offset = 0,
        },
        emoji = {
            name = "emoji",
            module = "blink.compat.source",
            enabled = true,
            score_offset = -3,
        },
        copilot = {
            name = "copilot",
            module = "blink.compat.source",
            enabled = false,
        },
    },
}

return sources

--[[
providers = {
    lsp = {
        -- provider name
        --name = 'LSP',
        -- provider module
        --module = 'blink.cmp.sources.lsp',
        -- whether or not to enable the provider
        --enabled = true,
        -- function to transform the items before they're returned
        --transform_items = nil,
        -- whether or not to show the items
        --should_show_items = true,
        -- maximum number of items to return
        --max_items = nil,
        -- minimum number of characters to trigger the provider
        --min_keyword_length = 0,
        -- if any of these providers return 0 items, it will fallback to this provider
        --fallback_for = {},
        -- boost/penalize the score of the items
        --score_offset = 0,
        -- override the source's functions
        --override = nil,
    },
}
]]

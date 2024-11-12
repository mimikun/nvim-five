---@module "blink.cmp"
---@type blink.cmp.Config
local opts = {
    keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "snippet_backward", "fallback" },
        ["<Down>"] = { "snippet_forward", "fallback" },
    },

    accept = {
        create_undo_point = true,
        --expand_snippet = require('luasnip').lsp_expand,
        auto_brackets = { enabled = false },
    },

    trigger = { signature_help = { enabled = false } },

    fuzzy = { prebuilt_binaries = { download = false } },

    sources = require("plugins.configs.blink-cmp.sources"),

    windows = {
        autocomplete = {
            ---@type string "preselect"|"manual"|"auto_insert"
            selection = "preselect",
            -- Controls how the completion items are rendered on the popup window
            draw = {
                ---@type string "label"|"none"
                align_to_component = "label",
            },
        },
    },
    highlight = { use_nvim_cmp_as_default = true },
    --- @type string "mono"|"normal"
    nerd_font_variant = "mono",
}

return opts

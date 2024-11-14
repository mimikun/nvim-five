local global = require("config.global")

---@type boolean
local cond = require("config.settings").use_avante

-- TODO: avante setting now
cond = true

---@type table
local build_cmd = {
    linux = "make BUILD_FROM_SOURCE=true",
    windows = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
}

---@type string
local build = global.is_windows and build_cmd.windows and build_cmd.linux

---@type table
local cmds = {
    "AvanteAsk",
    "AvanteToggle",
    "AvanteBuild",
    "AvanteEdit",
    "AvanteRefresh",
    "AvanteFocus",
    "AvanteSwitchProvider",
    "AvanteClear",
    "AvanteShowRepoMap",
}

---@type LazySpec[]
local dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    "HakonHarnes/img-clip.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    -- BUG: this plugin is not working, document not found. fxxk
    --{ "takeshiD/avante-status.nvim", lazy = false },
}

---@type string
local provider = global.is_work and "ollama" or "copilot"

---@type table
local opts = {
    provider = provider,
    auto_suggestions_provider = provider,
    vendors = {
        ---@type AvanteProvider
        ollama = {
            ["local"] = true,
            endpoint = "127.0.0.1:11434/v1",
            model = "codegemma",
            parse_curl_args = function(opts, code_opts)
                return {
                    url = opts.endpoint .. "/chat/completions",
                    headers = {
                        ["Accept"] = "application/json",
                        ["Content-Type"] = "application/json",
                    },
                    body = {
                        model = opts.model,
                        -- you can make your own message, but this is very advanced
                        messages = require("avante.providers").copilot.parse_messages(code_opts),
                        max_tokens = 2048,
                        stream = true,
                    },
                }
            end,
            parse_response = function(data_stream, event_state, opts)
                require("avante.providers").copilot.parse_response(data_stream, event_state, opts)
            end,
        },
    },
    behaviour = {
        -- Experimental stage
        auto_suggestions = false,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
    },
}

---@type LazySpec
local spec = {
    "yetone/avante.nvim",
    version = false,
    build = build,
    lazy = false,
    cmd = cmds,
    --keys = "",
    event = "VeryLazy",
    dependencies = dependencies,
    opts = opts,
    cond = cond,
    enabled = cond,
}

return spec

---@type boolean
local cond = require("config.settings").use_avante

-- TODO: avante setting now
cond = true

---@type table
local build_cmd = {
    linux = "make",
    windows = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false",
}

---@type string
local build = require("config.global").is_windows and build_cmd.windows and build_cmd.linux

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
    {
        -- TODO: config it
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
            -- recommended settings
            default = {
                embed_image_as_base64 = false,
                prompt_for_file_name = false,
                drag_and_drop = {
                    insert_mode = true,
                },
                -- required for Windows users
                --use_absolute_path = true,
            },
        },
    },
    "MeanderingProgrammer/render-markdown.nvim",
}

---@type LazySpec
local spec = {
    "yetone/avante.nvim",
    build = build,
    version = false,
    lazy = false,
    cmd = cmds,
    --keys = "",
    event = "VeryLazy",
    dependencies = dependencies,
    opts = {
        -- add any opts here
    },
    cond = cond,
    enabled = cond,
}

return spec

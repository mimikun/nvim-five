---@type LazySpec
local spec = {
    "saghen/blink.cmp",
    build = "cargo build --release",
    lazy = false,
    dependencies = require("plugins.configs.blink-cmp.dependencies"),
    opts = require("plugins.configs.blink-cmp.opts"),
    --cond = false,
    --enabled = false,
}

return spec

---@type LazySpec[]
local dependencies = {
    "saghen/blink.compat",
    "rafamadriz/friendly-snippets",
    "L3MON4D3/LuaSnip",
    "folke/lazydev.nvim",
    "hrsh7th/cmp-emoji",
}

if require("config.settings").use_github_copilot then
    table.insert(dependencies, "zbirenbaum/copilot.lua")
    table.insert(dependencies, "zbirenbaum/copilot-cmp")
end

return dependencies

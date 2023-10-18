-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local opt = vim.opt
local o = vim.o
local g = vim.g
local api = vim.api

-- 输出neovide_refresh_rate
-- vim.notify(vim.g.neovide_refresh_rate)
-- vim.notify(g.neovide_refresh_rate)

-- opt config
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.relativenumber = true
opt.completeopt = { "menuone", "noselect" }

-- o config
o.guifont = "JetBrainsMono Nerd Font:h10"

-- g config
-- g.neovide_transparency = 0.8
g.neovide_scroll_animation_length = 0.3
g.neovide_cursor_animation_length = 0.3
-- g.neovide_profiler = true
g.neovide_input_ime = true
-- g.neovide_refresh_rate = 60

local function set_ime(args)
    if args.event:match("Enter$") then
        vim.g.neovide_input_ime = true
    else
        vim.g.neovide_input_ime = false
    end
end

local ime_input = api.nvim_create_augroup("ime_input", { clear = true })

api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime
})

api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime
})


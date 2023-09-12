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


-- vim.cmd([[
--   set completeopt=menuone,noselect
--   set updatetime=300
--   
-- ]])
--
-- -- 创建一个自定义的 LSP 处理器
-- local show_line_diagnostics = function(_, result, ctx, _)
--   if ctx.bufnr == vim.api.nvim_get_current_buf() then
--     local lines = {}
--     for _, diagnostic in ipairs(result.diagnostics) do
--       table.insert(lines, string.format("%d: %s [%s]", diagnostic.range.start.line + 1, diagnostic.message, diagnostic.source))
--     end
--     local content = table.concat(lines, "\n")
--     local bufnr = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, true, vim.split(content, "\n"))
--     vim.api.nvim_open_win(bufnr, true, {
--       relative = "cursor",
--       width = 80,
--       height = #lines,
--       focusable = false,
--       style = "minimal",
--     })
--   end
-- end
--
-- -- 设置自定义的 LSP 处理器
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = show_line_diagnostics

-- 配置 Floating Window 样式
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- 设置错误信息显示在 Floating Window 中
--     virtual_text = false,
--     underline = true,
--     signs = true,
--     update_in_insert = false,
--   }
-- )

-- fold color
-- opt.fillchars = "fold: "
-- opt.foldmethod = "indent"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
-- opt.foldcolumn = "1"
-- opt.foldnestmax = 3
-- opt.foldminlines = 1
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99
-- opt.foldenable = true
-- opt.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
--
--

-- local ok, translate = pcall(require, "Translate")
-- if not ok then
--   vim.notify "Could not load translate"
--   return
-- end

require("translate").setup({
    default = {
        command = "translate_shell",
        -- output = "split",
    },
    preset = {
        output = {
          -- insert = {
          --   base = "bottom",
          --   off = 0,
          -- }
          -- floating = {
          --   border = "single",
          --   width = 0.6,
          --   height = 0.6,
          --   x = 0.5,
          --   y = 0.5,
          --   relative = "editor",
          --   style = "minimal",
          --   filetype = "Translate",
          --   winblend = 10,
          --   row = 10,
          --   col = 10,
          -- }
          -- table = {
          --   base = "bottom",
          --   off = 0,
          -- },
            split = {
                -- position = "bottom",
                -- min_size = 10,
                -- max_size = 20,
			          -- filetype = "translate",
                append = false,
            },
        },
    },
})

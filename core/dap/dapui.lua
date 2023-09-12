return function()
	local icons = {
		ui = require("custom.core.icons").get("ui"),
		dap = require("custom.core.icons").get("dap"),
	}

	require("dapui").setup({
		icons = { expanded = icons.ui.ArrowOpen, collapsed = icons.ui.ArrowClosed, current_frame = icons.ui.Indicator },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
		},
		layouts = {
      {
        elements = {
          "scopes",
        },
        size = 0.25,
        position = "right",
      },
      {
        elements = {
					{
						id = "console",
						size = 0.7,
					},
					{
						id = "repl",
						size = 0.3,
					},
        },
        size = 0.3,
        position = "bottom",
      },
			-- {
			-- 	elements = {
			-- 		-- Provide as ID strings or tables with "id" and "size" keys
			-- 		{
			-- 			id = "scopes",
			-- 			size = 0.25, -- Can be float or integer > 1
			-- 		},
			-- 		{ id = "breakpoints", size = 0.25 },
			-- 		{ id = "stacks", size = 0.25 },
			-- 		{ id = "watches", size = 0.25 },
			-- 	},
			-- 	size = 25,
			-- 	position = "left",
			-- },
			-- {
			-- 	elements = {
			-- 		{
			-- 			id = "repl",
			-- 			size = 0.3,
			-- 		},
			-- 		{
			-- 			id = "console",
			-- 			size = 0.7,
			-- 		},
			-- 	},
			-- 	size = 20,
			-- 	position = "bottom",
			-- },
		},
		-- Requires Nvim version >= 0.8
		controls = {
			enabled = true,
			-- Display controls in this session
			element = "repl",
			icons = {
				pause = icons.dap.Pause,
				play = icons.dap.Play,
				step_into = icons.dap.StepInto,
				step_over = icons.dap.StepOver,
				step_out = icons.dap.StepOut,
				step_back = icons.dap.StepBack,
				run_last = icons.dap.RunLast,
				terminate = icons.dap.Terminate,
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			mappings = { close = { "q", "<Esc>" } },
		},
		windows = { indent = 1 },
	})
end

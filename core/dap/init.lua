return function()
	local icons = { dap = require("custom.core.icons").get("dap") }
	local colors = require("custom.core").get_palette()

	local dap = require("dap")
	local dapui = require("dapui")

  -- dap.set_log_level('info')
-- require('telescope').extensions.dap.configurations()

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	-- dap.listeners.after.event_terminated["dapui_config"] = function()
	-- 	dapui.close()
	-- end
	-- dap.listeners.after.event_exited["dapui_config"] = function()
	-- 	dapui.close()
	-- end

	-- We need to override nvim-dap's default highlight groups, AFTER requiring nvim-dap for catppuccin.
	vim.api.nvim_set_hl(0, "DapStopped", { fg = colors.green })

	vim.fn.sign_define(
		"DapBreakpoint",
		{ text = icons.dap.Breakpoint, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define(
		"DapBreakpointCondition",
		{ text = icons.dap.BreakpointCondition, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define("DapStopped", { text = icons.dap.Stopped, texthl = "DapStopped", linehl = "", numhl = "" })
	vim.fn.sign_define(
		"DapBreakpointRejected",
		{ text = icons.dap.BreakpointRejected, texthl = "DapBreakpoint", linehl = "", numhl = "" }
	)
	vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint, texthl = "DapLogPoint", linehl = "", numhl = "" })

	-- Config lang adaptors
	-- require("custom.core.dap.dap-lldb")
	require("custom.core.dap.dap-debugpy")
	-- require("custom.core.dap.dap-jdtls")
	-- require("custom.core.dap-dlv")
end

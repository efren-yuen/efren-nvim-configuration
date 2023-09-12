local dap = require("dap")

local install_root_dir = vim.fn.stdpath "data" .. "/mason"
local extension_path = install_root_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" }
    }
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		-- program = function()
		-- 	return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		-- end,
    program = "${fileDirname}/${fileBasenameNoExtension}",
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
    args = {},
    externalConsole = false,
    -- targetArchitecture = "x86_64",
		-- runInTerminal = true,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

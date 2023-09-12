local dap = require("dap")

-- 获取当前文件所在目录
local function get_current_directory()
  return vim.fn.expand("%:p:h")
end

-- 判断文件是否存在
local function is_file_exist(file_path)
  local file = io.open(file_path, "r")
  if file then
    io.close(file)
    return true
  end
  return false
end

-- 运行系统命令并返回输出结果
local function run_command(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result:match("^%s*(.-)%s*$") -- 去除首尾空格和换行符
end

-- 拼接虚拟环境路径
local function get_venv_path()
  local project_root = get_current_directory()
  -- local machine = vim.fn.input('machine: ')
  -- print(machine)
  local venv_path = project_root .. "/.venv/bin/python"
  if is_file_exist(venv_path) then
    return venv_path
  end
  local pythonPath = run_command("which python")
  -- print("Python Interpreter Path:", pythonPath)
  return pythonPath
  -- return "python"
end


require("core.utils").load_mappings("python")

-- 执行 which python 命令获取 Python 解释器路径

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- dap.adapters.python = {
-- 	type = "executable",
-- 	command = mason_path .. "packages/debugpy/venv/bin/python",
-- 	args = { "-m", "debugpy.adapter" },
-- }

dap.adapters.python = {
  type = 'executable';
  command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",
		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
    justMyCode = false,
    console = 'integratedTerminal',
		program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = get_venv_path(),
		-- pythonPath = function()
		-- 	if not isempty(vim.env.CONDA_PREFIX) then
		-- 		return vim.env.CONDA_PREFIX .. "/bin/python"
  --     elseif is_file_exist('/.venv/bin/python3') then
  --       return "/.venv/bin/python3"
		-- 	else
		-- 		return "/usr/bin/python3"
		-- 	end
		-- end,
	},
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file with arguments',
    program = '${file}',
    justMyCode = false,
    console = 'integratedTerminal',
    args = function()
      local args_string = vim.fn.input('Arguments: ')
      return vim.split(args_string, ' +')
    end,
    pythonPath = get_venv_path(),
		-- pythonPath = function()
		-- 	if not isempty(vim.env.CONDA_PREFIX) then
		-- 		return vim.env.CONDA_PREFIX .. "/bin/python"
		-- 	else
		-- 		return "/usr/bin/python3"
		-- 	end
		-- end,
  },
}

-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- pcall(function()
--   vim.notify("mason path: " .. mason_path)
--   require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
--   -- require("dap-cpp").setup(mason_path .. "packages/lldb/bin/lldb-vscode")
--   -- require("dap-cpp").setup(mason_path .. "packages/codelldb/codelldb")
-- end)



-- local status, dap = pcall(require, 'dap')
-- if not status then
--   return
-- end
-- local dappython
-- status, dappython = pcall(require, 'dap-python')
-- if not status then
--   return
-- end
-- dap.configurations.python = {
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'Launch file (justMyCode = false)',
--     program = '${file}',
--     justMyCode = false,
--   },
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'Launch file with arguments (justMyCode = false)',
--     program = '${file}',
--     justMyCode = false,
--     args = function()
--       local args_string = vim.fn.input('Arguments: ')
--       return vim.split(args_string, ' +')
--     end,
--   },
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'Launch file (console = integratedTerminal, justMyCode = false)',
--     program = '${file}',
--     console = 'integratedTerminal',
--     justMyCode = false,
--     -- pythonPath = opts.pythonPath,
--   },
--   {
--     type = 'python',
--     request = 'launch',
--     name = 'Launch file with arguments (console = integratedTerminal, justMyCode = false)',
--     program = '${file}',
--     console = 'integratedTerminal',
--     justMyCode = false,
--     -- pythonPath = opts.pythonPath,
--     args = function()
--       local args_string = vim.fn.input('Arguments: ')
--       return vim.split(args_string, ' +')
--     end,
--   },
-- }
-- dappython.setup('~/.virtualenvs/debugpy/bin/python', {
--   include_configs = true,
--   console = 'integratedTerminal',
--   pythonPath = nil,
-- })
--



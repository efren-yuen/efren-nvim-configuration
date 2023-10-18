local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   rangeLimit = 3000,
--   lineFoldingOnly = true,
-- }

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "pyright", "volar", "lua_ls", "lemminx" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)

  local global_ts = '/usr/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup{
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
}
lspconfig.clangd.setup{
  offsetEncoding = { "utf-16" },
  cmd = {
    "clangd",
    "--offset-encoding=utf-16"
  }
}
-- lspconfig.clangd.offsetEncoding = { "utf-8" }
-- lspconfig.pyright.setup { blabla}

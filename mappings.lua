local M = {}

-- local showSymbolFinder = function ()
--     local opts= {
--         symbols = {
--             "package",
--             "constant",
--             "field",
--             "interface",
--             "class",
--             "constructor",
--             "method",
--         }
--     }
--     if vim.bo.filetype == "vim" then
--         opts.symbols = { "function" }
--     end
--     require('telescope.builtin').lsp_document_symbols(opts)
-- end

-- local lsp_opts= {
--     symbols = {
--         "package",
--         "constant",
--         "field",
--         "interface",
--         "class",
--         "constructor",
--         "method",
--     }
-- }

-- 定义一个函数来设置断点条件
-- function set_breakpoint_condition()
--     local input_condition = vim.fn.input('Enter breakpoint condition: ')
--     if input_condition and input_condition ~= '' then
--         -- require('dap').set_breakpoint(input_condition, nil, vim.fn.input('Enter log message: '))
--         require('dap').toggle_breakpoint(input_condition, nil, vim.fn.input('Enter log message: '))
--         -- local breakpoint = require('dap').set_breakpoint(input_condition, nil, vim.fn.input('Enter log message: ')
--         -- breakpoint.set_condition(input_condition)
--     end
-- end


M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    ["<leader>;"] = { "<cmd>Nvdash<cr>", "Nvdash", opts = { nowait = true } },

    -- project
    ["<leader>fp"] = {
			noremap = true,
			silent = true,
			nowait = true,
      function ()
        require("telescope").extensions.projects.projects({})
      end
      , "projects"
    },

    ["<leader>ls"] = { "<Cmd>Telescope lsp_document_symbols<CR>", "lsp_document_symbols" },

    -- code running
    ["<leader>rc"] = { "<Cmd>RunCode<CR>", "run code" },
    -- ["<leader>rp"] = { "<Cmd>RunProject<CR>", "run project" },
    ["<leader>rx"] = { "<Cmd>RunClose<CR>", "run close" },


    ["<leader>fx"] = { "<Cmd>Telescope quickfix<CR>", "quickfix", opts = { noremap = true, silent = true} },

    -- ["<leader>ls"] = {
    --   function ()
    --     showSymbolFinder()
    --   end, "lsp_document_symbols"
    -- },


    -- ["<leader>lt"] = { "<Cmd>LspRestart<CR>", "lsp_restart" },
    ["<leader>lt"] = {
      function ()
        vim.api.nvim_command("LspRestart")
        -- require("dap").setup()
        -- require("custom.core.dap.dap-debugpy").get_venv_path()
        -- vim.api.nvim_command(":lua require'dap'.reload()")
      end, "lsp_restart" },
    -- translate
    ["<leader>tt"] = { "viw:Translate ZH<CR>", "to en"},

    -- lazygit
    ["<leader>gg"] = { "<cmd>LazyGit<cr>", "LazyGit" },
    -- lazydocker
    ["<leader>gd"] = { "<cmd>LazyDocker<CR>", "LazyDocker", opts = { noremap = true, silent = true} },




  },

}

-- more keybinds!

M.nvimtree = {
  plugin = true,
  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
  },
}

M.markdown = {
  plugin = true, -- Importan
  n = {
    ["<leader>ms"] = { "<cmd>MarkdownPreview<cr>", "MD Start" },
    ["<leader>md"] = { "<cmd>MarkdownPreviewStop<cr>", "MD Stop" },
  }
}


M.c = {
  plugin = true,
  n = {
    ["<leader>lc"] = { "<cmd>CMakeSelectCwd<cr>", "cmake select cwd" },
    ["<leader>lv"] = { "<cmd>CMakeGenerate<cr>", "cmake generate" },
    ["<leader>lb"] = { "<cmd>CMakeBuild<cr>", "cmake build" },
    ["<leader>ln"] = { "<cmd>CMakeRun<cr>", "cmake run" },
    ["<leader>ds"] = { "<cmd>CMakeDebug<cr>", "cmake debug" },

    ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    -- breakpoint_condition
    -- ["<leader>dT"] = { "<cmd>lua set_breakpoint_condition()<CR>", "BreakpointCondition" },
    ["<leader>dT"] = { function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "BreakpointCondition" },
    ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>dl"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },

    ["gd"] = {
      "<Cmd>Telescope lsp_definitions<CR>",
      -- function()
      --   vim.lsp.buf.definition()
      -- end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      "<Cmd>Telescope lsp_implementations<CR>",
      -- function()
      --   vim.lsp.buf.implementation()
      -- end,
      "LSP implementation",
    },
  }
}

M.html = {
  plugin = true, -- Importan
  n = {
    ["<leader>ds"] = { "<cmd>BrowserPreview<cr>", "HTML Start" },
    ["<leader>dd"] = { "<cmd>BrowserStop<cr>", "HTML Stop" },
  }
}

M.python = {
  plugin = true, -- Importan
  n = {
    -- ["<leader>co"] = { "<cmd>Telescope conda<cr>", "Conda" },
    -- dap
    ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "PY Start" },
    ["<leader>dl"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },

    ["gd"] = {
      "<Cmd>Telescope lsp_definitions<CR>",
      -- function()
      --   vim.lsp.buf.definition()
      -- end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      "<Cmd>Telescope lsp_implementations<CR>",
      -- function()
      --   vim.lsp.buf.implementation()
      -- end,
      "LSP implementation",
    },
  }
}

M.jdtls = {
  plugin = true, -- Importan
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      "<Cmd>Telescope lsp_definitions<CR>",
      -- function()
      --   vim.lsp.buf.definition()
      -- end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["gi"] = {
      "<Cmd>Telescope lsp_implementations<CR>",
      -- function()
      --   vim.lsp.buf.implementation()
      -- end,
      "LSP implementation",
    },

    -- ["<leader>ls"] = {
    --   function()
    --     vim.lsp.buf.signature_help()
    --   end,
    --   "LSP signature help",
    -- },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      "<Cmd>Telescope lsp_references<CR>",
      -- function()
      --   vim.lsp.buf.references()
      -- end,
      "LSP references",
    },

    ["<leader>f"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
    -- lsp
    ["<leader>la"] = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    ["<leader>ld"] = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
    ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    -- maven
    ["<leader>lm"] = { "<cmd>Maven<CR>", "maven", opts = { noremap = true, silent = true} },

    -- dap
    ["<leader>dt"] = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    ["<leader>db"] = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
    ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    ["<leader>dd"] = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
    ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
    ["<leader>do"] = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
    ["<leader>du"] = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
    ["<leader>ds"] = { "<cmd>lua require'dap'.continue()<cr>", "Java Start" },
    ["<leader>dl"] = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
  },

}
return M

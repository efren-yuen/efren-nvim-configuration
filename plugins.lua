local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- { "linduxed/colemak.nvim",
  --   lazy = false,
  --   event = "BufRead",
  --   config = function()
  --     require("colemak").setup()
  --   end,
  -- },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function() require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
    opt = overrides.lspconfig,
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "syntax")
      require("nvim-treesitter.configs").setup(opts)
      require("nvim-treesitter.install").prefer_git = true
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {"nvim-treesitter/nvim-treesitter"},
      {
        "ahmedkhalf/project.nvim",
        lazy = false,
        event = "BufReadPost",
        config = require("custom.configs.project"),
      },

      -- Android and IOS
      -- {
      --   "dimaportenko/telescope-simulators.nvim"
      -- }
    },
    opts = overrides.telescope,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        require("custom.configs.surround")
      })
    end
    -- config = require("custom.configs.surround").setup(),
  },

  {
    "alexghergh/nvim-tmux-navigation",
    enable = false,
    lazy = true,
    config = function()
      require'nvim-tmux-navigation'.setup {
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<A-h>",
          down = "<A-j>",
          up = "<A-k",
          right = "<A-l>",
          last_active = "<A-Tab>",
          next = "<A-n>",
        }
      }
    end,
  },

  {
    "VidocqH/lsp-lens.nvim",
    lazy = true,
    event = "BufRead",
    config = function ()
      require'lsp-lens'.setup({
        enable = true,
        include_declaration = false,      -- Reference include declaration
        sections = {                      -- Enable / Disable specific request
          definition = false,
          references = true,
          implements = true,
        },
        ignore_filetype = {
          "prisma",
        },
      })
    end
  },

  {
    "RRethy/vim-illuminate",
    lazy = true,
    event = "BufRead",
  },

  {
    "edluffy/specs.nvim",
    enabled = false,
    lazy = true,
    event = "BufRead",
    config = function ()
      require('specs').setup{
          show_jumps  = true,
          min_jump = 30,
          popup = {
              delay_ms = 0, -- delay before popup displays
              inc_ms = 10, -- time increments used for fade/resize effects 
              blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
              width = 10,
              winhl = "PMenu",
              fader = require('specs').linear_fader,
              -- fader = require('specs').pulse_fader,
              resizer = require('specs').shrink_resizer
          },
          ignore_filetypes = {},
          ignore_buftypes = {
              nofile = true,
          },
      }
    end
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
    event = "BufRead",
    config = require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      }
    }
  },

  {
    "nvim-focus/focus.nvim",
    version = "*",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("focus").setup({
        enable = true, -- Enable module
        commands = true, -- Create Focus commands
        autoresize = {
            enable = true, -- Enable or disable auto-resizing of splits
            width = 0, -- Force width for the focused window
            height = 0, -- Force height for the focused window
            minwidth = 0, -- Force minimum width for the unfocused window
            minheight = 0, -- Force minimum height for the unfocused window
            height_quickfix = 10, -- Set the height of quickfix panel
        },
        split = {
            bufnew = false, -- Create blank buffer for new split windows
            tmux = false, -- Create tmux splits instead of neovim splits
        },
        ui = {
            number = false, -- Display line numbers in the focussed window only
            relativenumber = false, -- Display relative line numbers in the focussed window only
            hybridnumber = false, -- Display hybrid line numbers in the focussed window only
            absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

            cursorline = true, -- Display a cursorline in the focussed window only
            cursorcolumn = false, -- Display cursorcolumn in the focussed window only
            colorcolumn = {
                enable = false, -- Display colorcolumn in the foccused window only
                list = '+1', -- Set the comma-saperated list for the colorcolumn
            },
            signcolumn = true, -- Display signcolumn in the focussed window only
            winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
        }
      })
    end
  },

  {
    "lambdalisue/suda.vim",
    lazy = true,
    event = "VeryLazy",
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "BufRead",
    config = function()
      require "custom.configs.notify"
    end,
  },
  {
    "folke/noice.nvim",
    enabled = false,
    lazy = true,
    event = "BufRead",
    config = function()
      require "custom.configs.noice"
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  -- web-tools
  {
    "ray-x/web-tools.nvim",
    lazy = true,
    -- ft = {"html", "css", "javascript", "typescript", "vue", "svelte", "lua", "json", "yaml", "toml", "hurl"},
    ft = {"html", "css", "javascript", "typescript", "json", "yaml"},
    cmd = {
      "BrowserSync",
      "BrowserOpen",
      "BrowserPreview",
      "BrowserRestart",
      "BrowserStop",
      "TagRename",
      "HurlRun",
    },
    config = function()
      require'web-tools'.setup({
        keymaps = {
          rename = nil,  -- by default use same setup of lspconfig
          repeat_rename = '.', -- . to repeat
        },
        hurl = {  -- hurl default
          show_headers = false, -- do not show http headers
          floating = false,   -- use floating windows (need guihua.lua)
          formatters = {  -- format the result by filetype
            json = { 'jq' },
            html = { 'prettier', '--parser', 'html' },
          },
        },
      })
      require("core.utils").load_mappings("html")
    end,
  },

  {
    "uga-rosa/translate.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require "custom.configs.translate"
    end,
  },

  -- ufo
  {
    "kevinhwang91/nvim-ufo",
    lazy = true,
    event = "VeryLazy",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end },
      { "zM", function() require("ufo").closeAllFolds() end },
      { "K", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end }
    },
    dependencies = {
      "kevinhwang91/promise-async",
      lazy = true,
      event = "VeryLazy",
    },
    config = function()
      -- Fold options
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      vim.o.foldcolumn = "0" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      require("ufo").setup()
    end,
  },

  -- git
  -- lazy.nvim
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    event = "VeryLazy",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },

  {
    "crnvl96/lazydocker.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      popup_window = {
        enter = true,
        focusable = true,
        zindex = 40,
        position = "50%",
        relative = "editor",
        size = {
            width = "90%",
            height = "90%",
        },
        buf_options = {
            modifiable = true,
            readonly = false,
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            winblend = 0,
        },
        border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
                top = " Lazydocker ",
            },
        },
      }
    },  -- automatically calls `require("lazydocker").setup()`
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },

  -- sql language server
  {
    "nanotee/sqls.nvim",
    lazy = true,
    ft = "sql",
    config = require('lspconfig').sqlls.setup{
      on_attach = function (client, bufnr)
        require('sqlls').on_attach(client, bufnr)
      end
    }
  },

  -- java language server
  {
    "mfussenegger/nvim-jdtls",
    lazy = true,
    ft = {"java"},
    config = require("custom.core.dap.dap-jdtls"),
    opts = overrides.jdtls,
  },


  {
    "eatgrass/maven.nvim",
    lazy = true,
    cmd = { "Maven", "MavenExec" },
    -- dependencies = "nvim-lua/plenary.nvim",
    ft = {"java"},
    dependencies = {
      -- "WS-Na/telescope-maven-search",
      "nvim-lua/plenary.nvim",
    },
    -- config = function()
    --   require('telescope').extensions.maven.projects()
    -- end,
    config = function()
      require('maven').setup({
        -- executable="./mvnw"
        executable="mvn"
      })
    end
  },

  -- markdown language server
  {
    'iamcco/markdown-preview.nvim',
    lazy = true,
    ft = {'markdown','md'},
    build = "cd app && yarn install",
    opts = overrides.markdown,
    config = function()
      require("core.utils").load_mappings("markdown")
    end
  },

  {
    "aspeddro/slides.nvim",
    lazy = true,
    ft = {'markdown', 'md'},
    config = function ()
      require'slides'.setup{
        -- bin = 'sildes',
        -- fullscreen = true,
      }
    end
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    -- config = function()
    --   require("lvim.core.dap").setup()
    -- end,
    lazy = true,
    cmd = {
      "DapSetLogLevel",
      "DapShowLog",
      "DapContinue",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
    },
	  config = require("custom.core.dap"),
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = require("custom.core.dap.dapui")
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        lazy = true,
        event = "BufRead",
        -- config = require'telescope'.load_extension('dap')
      },
      -- {
      --   "mfussenegger/nvim-dap-python",
      --   "nvim-neotest/neotest",
      --   "nvim-neotest/neotest-python",
      --   lazy = true,
      --   ft = "py"
      -- }
    },
  },


  -- copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   lazy = true,
  --   event = "InsertEnter",
  --   opts = overrides.copilot,
  -- },

  {
		"github/copilot.vim",
    lazy = true,
    event = "InsertEnter",
		config = function()
			vim.g.copilot_enabled = true
      vim.g.copilot_proxy = "localhost:10809"
			vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- vim.g.copilot_tab_fallback = ''
      -- vim.g.copilot_disable_tab_completion = 1
			-- vim.api.nvim_set_keymap('n', '<leader>go', ':Copilot<CR>', { silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>ge', ':Copilot enable<CR>', { silent = true })
			-- vim.api.nvim_set_keymap('n', '<leader>gd', ':Copilot disable<CR>', { silent = true })
			vim.api.nvim_set_keymap('i', '<c-p>', '<Plug>(copilot-suggest)', {})
			vim.api.nvim_set_keymap('i', '<c-j>', '<Plug>(copilot-next)', { silent = true })
			vim.api.nvim_set_keymap('i', '<c-k>', '<Plug>(copilot-previous)', { silent = true })
      -- vim.cmd('imap <expr> <Plug>(vimrc:copilot-dummy-map) copilot#Accept("\\<Tab>")')
			vim.cmd('imap <silent><script><expr> <C-l> copilot#Accept("")')
			vim.cmd([[
			let g:copilot_filetypes = {
	       \ 'TelescopePrompt': v:false,
	     \ }
			]])
		end
	},

  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = "InsertEnter",
   --  config = function ()
			-- vim.g.copilot_no_tab_map = true
   --  end,
    -- dependencies = {
    --   {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --       require("copilot_cmp").setup()
    --     end,
    --   },
    -- },
    opts = overrides.cmp,
  },

  -- leetcode
  {
    "Dhanus3133/LeetBuddy.nvim",
    enabled = false,
    lazy = true,
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("leetbuddy").setup({
        -- domain = "cn",
        language = "java",
      })
    end,
    keys = {
      { "<leader>rq", "<cmd>LBQuestions<cr>", desc = "List Questions" },
      { "<leader>rl", "<cmd>LBQuestion<cr>", desc = "View Question" },
      { "<leader>rr", "<cmd>LBReset<cr>", desc = "Reset Code" },
      { "<leader>rt", "<cmd>LBTest<cr>", desc = "Run Code" },
      { "<leader>rs", "<cmd>LBSubmit<cr>", desc = "Submit Code" },
    },
  },

}

return plugins

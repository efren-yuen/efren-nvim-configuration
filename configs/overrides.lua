local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "java",
    "python",
    "dockerfile",
    "vue",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
  highlight = {
    enable = true,
    disable = function (lang, buf)
        local max_filesize = 10 * 1000 * 1024 -- 100 KB = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end
  }
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- java stuff
    "jdtls",
    "java-debug-adapter",
    "google-java-format",

    -- python stuff
    "pyright",
    "debugpy",

    -- docker
    "dockerfile-language-server"
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    git_ignored = false,
    dotfiles = false,
    git_clean = false,
    no_buffer = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 400,
  },
  actions = {
    open_file ={
      quit_on_open = true
    }
  },
  update_focused_file = {
    enable = true,
    debounce_delay = 15,
    update_root = true,
    ignore_list = {},
  },
  renderer = {
    group_empty = true,
    root_folder_label = true,
    highlight_git = true,
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "+",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },

    -- special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    -- symlink_destination = true,
    --
    -- icons = {
    --   show = {
    --     git = true,
    --   },
    -- },
  },
}

M.telescope = {
  -- extensions = {
  --   conda = {
  --     anaconda_path = "/opt/anaconda/",
  --   }
  -- },

  -- defaults = {
  -- extensions_list = { "themes", "terms", "projects", "notify", "dap", "ui-select" },
  -- extensions_list = { "themes", "terms", "notify", "dap", "ui-select", "conda" },
  extensions_list = { "themes", "terms", "notify", "dap", "ui-select" },

  -- }
  -- defaults = {
  --   lsp_code_actions = {
  --     theme = 'cursor',
  --     sorter = 'kind',
  --   }
  -- }
}

M.copilot = {
  -- Possible configurable fields can be found on:
  -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
  suggestion = {
    enabled = false,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = {
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
}

local cmp = require "cmp"
M.cmp = {
  completion = {
    completeopt = "menu, noinsert, noselect",
    keyword_length = 1,
  },
  mapping = {
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
  },
  sources = {
    { name = "nvim_lsp", group_index = 2 },
    { name = "copilot",  group_index = 2 },
    { name = "luasnip",  group_index = 2 },
    { name = "buffer",   group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "path",     group_index = 2 },
  },
}

return M

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },

      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        norg = {
          icon = "󰎛",
          name = "Neorg",
        },
        proto = {
          icon = "󱍢",
          name = "Protobuf",
        },
        http = {
          icon = "",
          name = "Http",
        },
        env = {
          icon = "󰏗",
          name = "Env",
        },
      },
      default = true,
    },
  },

  {
    "nanozuki/tabby.nvim",
    commit = "d5bcb49109634720e05dd1aeff1c95578c8aa5b2",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      local theme = {
        fill = "TabLineFill",
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        win = "TabLine",
        tail = "TabLine",
      }
      require("tabby.tabline").set(function(line)
        return {
          buf_name = {
            mode = "shorten",
          },
          {
            { "  ", hl = theme.head },
            line.sep(" ", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          {
            line.sep(" ", theme.tail, theme.fill),
            { " 󱐰 ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
      vim.keymap.set("n", "<Leader>tr", ":TabRename<Space>")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
      scope = {
        show_start = false,
        include = {
          node_type = { "*" },
        },
        enabled = false,
      },
      indent = {
        char = "│",
      },
    },
  },
  {
    "OXY2DEV/foldtext.nvim",
    lazy = false,
    commit = "f11adecff5fa1e77ce82f196a1573c54fabfb258",
  },
}

return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        float = {
          transparent = false, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
        },
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {
          mocha = {
            base = "#000000",
            mantle = "#000000",
            crust = "#000000",
          },
        },
        custom_highlights = {},
        default_integrations = true,
        auto_integrations = false,
        integrations = {
          -- blink_cmp = {
          --   style = "bordered",
          -- },
					cmp = true,
          gitsigns = true,
          treesitter = true,
          neotree = true,
					native_lsp = {
							enabled = false,
					},
        },
      })

      -- setup must be called before loading
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = true,
    config = function()
      require("onedarkpro").setup({
        styles = {
          methods = "bold",
          strings = "bold,italic",
          comments = "italic",
          keywords = "bold,italic",
          constants = "bold,italic",
          parameters = "italic",
        },
        -- options = {
        --   transparency = not vim.g.neovide,
        -- },
      })
      vim.cmd.colorscheme("onedark_dark")
    end,
  },
  {
    "samharju/synthweave.nvim",
    commit = "50cb17af14dbdf8a2af634c40b9b20298f67aba0",
    lazy = true,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("synthweave")
      vim.cmd.colorscheme("synthweave-transparent")
      -- Make LSP hover borders more visible
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#a2c7e5", bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
    end,
  },
  {
    "yazeed1s/oh-lucy.nvim",
    commit = "2d94e9b03efe4c50f4653b6f2b7b200d970fe1aa",
    lazy = true,
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme("oh-lucy")
      vim.cmd.colorscheme("oh-lucy-evening")
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      -- local transparency = false
      local transparency = true
      if vim.g.neovide then
        transparency = false
      end

      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = false, -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = false,
          transparency = transparency,
        },

        groups = {
          border = "muted",
          link = "iris",
          panel = "surface",

          error = "love",
          hint = "iris",
          info = "foam",
          note = "pine",
          todo = "rose",
          warn = "gold",

          git_add = "foam",
          git_change = "rose",
          git_delete = "love",
          git_dirty = "rose",
          git_ignore = "muted",
          git_merge = "iris",
          git_rename = "pine",
          git_stage = "iris",
          git_text = "rose",
          git_untracked = "subtle",

          h1 = "iris",
          h2 = "foam",
          h3 = "rose",
          h4 = "gold",
          h5 = "pine",
          h6 = "foam",
        },

        highlight_groups = {
          -- Comment = { fg = "foam" },
          -- VertSplit = { fg = "muted", bg = "muted" },
          DiagnosticUnderlineError = { underdouble = true, sp = "#d11500" },
          DiagnosticUnderlineWarn = { undercurl = false, sp = "#997b00" },
          DiagnosticUnderlineInfo = { undercurl = false, sp = "#0057d1" },
          DiagnosticUnderlineHint = { undercurl = false, sp = "#008c99" },
        },
        before_highlight = function(group, highlight, palette) end,
      })

      vim.cmd.colorscheme("rose-pine")
    end,
  },
}

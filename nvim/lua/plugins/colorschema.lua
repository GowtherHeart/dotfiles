return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    lazy = false,
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
        options = {
          transparency = not vim.g.neovide,
        },
      })
      vim.cmd.colorscheme("onedark_dark")
    end,
  },
  {
    "samharju/synthweave.nvim",
    commit = "50cb17af14dbdf8a2af634c40b9b20298f67aba0",
    lazy = true,
    priority = 1000,
  },
  {
    "yazeed1s/oh-lucy.nvim",
    commit = "2d94e9b03efe4c50f4653b6f2b7b200d970fe1aa",
    lazy = true,
    priority = 1000,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    priority = 1000,
    config = function()
      local transparency = false
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
    end,
  },
}

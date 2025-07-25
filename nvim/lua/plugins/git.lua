return {
  {
    "tpope/vim-fugitive",
		lazy = false,
    cmd = { "Git", "Gdiff", "Gstatus", "Gblame" },
  },
  {
    "lewis6991/gitsigns.nvim",
		lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local status, git = pcall(require, "gitsigns")
      if not status then
        return
      end

      git.setup({
        signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })

      vim.keymap.set("n", "rl", ":Gitsigns blame_line<CR>")
      vim.keymap.set("n", "rn", ":Gitsigns next_hunk<CR>")
      vim.keymap.set("n", "rb", ":Gitsigns prev_hunk<CR>")
      vim.keymap.set("n", "rp", ":Gitsigns preview_hunk_inline<CR>")
      vim.keymap.set("n", "rd", ":Gitsigns diffthis<CR>")
      vim.keymap.set("n", "ra", ":Gitsigns stage_hunk<CR>")
      vim.keymap.set("n", "rq", ":Gitsigns reset_hunk<CR>")
    end,
  },
}

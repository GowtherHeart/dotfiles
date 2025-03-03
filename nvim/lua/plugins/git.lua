return {
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
			numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				interval = 0,
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
		},
		keys = {
			{ "rl", "<cmd>Gitsigns blame_line<cr>", desc = "Git blame line" },
			{ "rn", "<cmd>Gitsigns next_hunk<cr>", desc = "Git next hunk" },
			{ "rb", "<cmd>Gitsigns prev_hunk<cr>", desc = "Git prev hunk" },
			{ "rp", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Git preview hunk inline" },
			{ "rd", "<cmd>Gitsigns diffthis<cr>", desc = "Git diffthis" },
			{ "ra", "<cmd>Gitsigns stage_hunk<cr>", desc = "Git stage hunk" },
			{ "rab", "<cmd>Gitsigns stage_buffer<cr>", desc = "Git stage buffer" },
			{ "rq", "<cmd>Gitsigns reset_hunk<cr>", desc = "Git reset hunk" },
			{ "rqa", "<cmd>Gitsigns reset_buffer<cr>", desc = "Git reset buffer" },
		},
	},
}

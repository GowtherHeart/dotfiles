---------------------------------------------
---------------------------------------------
-- BASE CONFIG
---------------------------------------------
---------------------------------------------
-- vim.opt.conceallevel = 3 -- remove markdown and neorg syntax
-- vim.opt.conceallevel = 2 -- remove markdown and neorg syntax
-- vim.opt.conceallevel = 0 -- remove markdown and neorg syntax
vim.opt.conceallevel = 0 -- remove markdown and neorg syntax
vim.o.updatetime = 0

-- File
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- SPEED
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_go_provider = 0
vim.g.loaded_ruby_provider = 0

-- Off swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Mouse
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- statusline
vim.opt.laststatus = 3

-- Base
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "no"
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.showcmd = false
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.shell = "fish"
vim.o.timeoutlen = 400

-- tabline
vim.o.showtabline = 2
-- vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

-- chars
vim.opt.list = true
vim.opt.listchars = { eol = "↵" }
vim.cmd("set listchars+=tab:\\ \\ ")
vim.opt.iskeyword = { "@", "48-57", "192-255" }

-- indent
vim.opt.smarttab = true
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.shiftwidth = 4

-- others
vim.opt.breakindent = true
vim.opt.wildoptions = "fuzzy"
vim.opt.pumblend = 10
vim.opt.pumheight = 10

---------------------------------------------
---------------------------------------------
-- LSP
---------------------------------------------
---------------------------------------------
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

---------------------------------------------
---------------------------------------------
-- NEOVIDE
---------------------------------------------
---------------------------------------------

-- font
-- vim.o.guifont = "Source Code Pro:h20"
-- vim.o.guifont = "Hack Nerd Font Mono:h20"
-- vim.o.guifont = "FiraCode Nerd Font Mono:h20"
vim.o.guifont = "Maple Mono:h20"
-- vim.o.guifont = "AnonymicePro Nerd Font Mono:h21"
-- vim.o.guifont = "Agave Nerd Font Mono:h21"
-- vim.o.guifont = "Hasklug Nerd Font Mono:h21"
-- vim.o.guifont = "Hasklug Nerd Font Mono:h20"

-- cursor
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_cursor_vfx_mode = "sonicboom"
vim.g.neovide_cursor_animate_in_insert_mode = true

-- animation
vim.g.neovide_cursor_vfx_mode = ""
-- vim.g.neovide_cursor_animation_length = 0
-- vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_refresh_rate = 144

-- config
vim.g.neovide_input_use_logo = 1
vim.g.neovide_hide_mouse_when_typing = 1
vim.g.neovide_input_macos_option_key_is_meta = true

vim.g.neovide_opacity = 0.9
vim.g.neovide_normal_opacity = 0.9

vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- BASE CONFIG
vim.opt.conceallevel = 0

-- File
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Disable unused providers for faster startup
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Disable backup/swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = false

-- Mouse
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- statusline
vim.opt.laststatus = 3

-- Performance settings
vim.o.timeoutlen = 300
vim.opt.ttimeoutlen = 10
vim.opt.ttyfast = true
vim.opt.updatetime = 250
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 5000

-- Memory optimization
vim.opt.history = 100
vim.opt.synmaxcol = 200
vim.opt.lazyredraw = true

-- Project-based caching
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.opt.shada = "'100,<50,s10,h,f1"

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

-- tabline
vim.o.showtabline = 2
-- vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

-- chars
vim.opt.list = true
-- vim.opt.listchars = { eol = "↵" }
vim.opt.listchars = { eol = "󱞧" }
-- vim.opt.listchars = { eol = "󱞱" }
-- vim.opt.listchars = { eol = "" }
-- vim.opt.listchars = { eol = "" }

-- vim.opt.listchars = { eol = "" }
vim.cmd("set listchars+=tab:\\ \\ ")
vim.opt.iskeyword = { "@", "48-57", "192-255" }

-- indent
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- others
vim.opt.breakindent = true
vim.opt.wildoptions = "fuzzy"
vim.opt.pumblend = 0
vim.opt.pumheight = 10

-- LSP CONFIGURATION
vim.diagnostic.config({
  float = {
    border = "rounded",
  },
	-- virtual_lines = true,
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

-- NEOVIDE CONFIGURATION
if vim.g.neovide then
  vim.o.guifont = "Maple Mono:h16"
  vim.g.neovide_cursor_vfx_mode = ""
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_input_use_logo = 1
  vim.g.neovide_hide_mouse_when_typing = 1
  vim.g.neovide_input_macos_option_key_is_meta = true
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_macos_simple_fullscreen = true
end

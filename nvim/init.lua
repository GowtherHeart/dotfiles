require("config.settings")
require("config.keymap")
require("config.autocmd")
require("config.lazy")
require("local.pydochide")


vim.lsp.enable('gopls', false)
vim.lsp.enable('rust_analyzer', false)
-- vim.lsp.enable('pyrefly')
vim.lsp.enable('pyright')


-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = function()
--     vim.cmd("redir >> ~/.local/state/nvim/exit.log")
--     vim.cmd("silent messages")
--     vim.cmd("redir END")
--   end
-- })

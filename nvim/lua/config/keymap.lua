local keymap = vim.keymap

-- Disable unused keys
keymap.set("", "q", "<Nop>")
keymap.set("", "s", "<Nop>")
keymap.set("", "r", "<Nop>")

-- Disable function keys in insert mode
for i = 1, 24 do
  keymap.set("i", "<F" .. i .. ">", "<Nop>")
end

-- BUFFER OPERATIONS
-- Delete without clipboard
keymap.set("n", "dw", 'vb"_d')
keymap.set("n", "D", '"_D')
keymap.set("v", "d", '"_d')
keymap.set("n", "dd", '"_dd')

-- Cut and write without clipboard
keymap.set("n", "C", '"_C')
keymap.set("n", "cc", '"_cc')
keymap.set("n", "ce", '"_ce')
keymap.set("n", "cb", '"_cb')
keymap.set("n", "c", '"_c')
keymap.set("v", "c", '"_c')

keymap.set("n", "x", '"_ca')
keymap.set("n", "qq", "<cmd>close<CR>")

-- WINDOW MANAGEMENT
keymap.set("n", "ss", "<cmd>split<Return><C-w>w")
keymap.set("n", "sv", "<cmd>vsplit<Return><C-w>w")

-- TAB MANAGEMENT
keymap.set("n", "tt", "<cmd>tabnew<CR>")
keymap.set("n", "ts", "<cmd>tab split<CR>")

keymap.set("", "<BS>", "<Nop>")

-- Tab navigation (Space + number)
for i = 1, 9 do
  keymap.set("n", "<Space>" .. i, "<cmd>tabn " .. i .. "<CR>")
end
-- Use different keys for tab navigation to preserve <C-i> jump forward
keymap.set("n", "<leader>k", "<cmd>tabnext<CR>")
keymap.set("n", "<leader>j", "<cmd>tabprev<CR>")

-- MOVEMENT
keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
keymap.set("i", "<F1>", "<Esc>", { noremap = true, silent = true })
keymap.set({ "n", "v" }, "<leader>,", ";", { noremap = true, silent = true })

-- LSP
keymap.set("n", "<leader>rl", "<cmd>lua vim.diagnostic.reset()<CR>")

-- NEOVIDE
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

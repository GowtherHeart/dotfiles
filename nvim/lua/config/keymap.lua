local keymap = vim.keymap

---------------------------------------------
---------------------------------------------
-- NOP
---------------------------------------------
---------------------------------------------
keymap.set("", "q", "<Nop>")
keymap.set("", "s", "<Nop>")
keymap.set("", "r", "<Nop>")
local function_keys = {}
for i = 1, 24 do
  table.insert(function_keys, "<F" .. i .. ">")
end
for _, key in ipairs(function_keys) do
  keymap.set("i", key, "<Nop>")
end

---------------------------------------------
---------------------------------------------
-- BUFFER
---------------------------------------------
---------------------------------------------
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

---------------------------------------------
---------------------------------------------
-- WINDOW
---------------------------------------------
---------------------------------------------
keymap.set("n", "ss", "<cmd>split<Return><C-w>w")
keymap.set("n", "sv", "<cmd>vsplit<Return><C-w>w")

---------------------------------------------
---------------------------------------------
-- TAB
---------------------------------------------
---------------------------------------------
keymap.set("n", "tt", "<cmd>tabnew<CR>")
keymap.set("n", "ts", "<cmd>tab split<CR>")

keymap.set("", "<BS>", "<Nop>")

keymap.set("n", "<F9>1", "<cmd>tabn 1<CR>")
keymap.set("n", "<F9>2", "<cmd>tabn 2<CR>")
keymap.set("n", "<F9>3", "<cmd>tabn 3<CR>")
keymap.set("n", "<F9>4", "<cmd>tabn 4<CR>")
keymap.set("n", "<F9>5", "<cmd>tabn 5<CR>")
keymap.set("n", "<F9>6", "<cmd>tabn 6<CR>")
keymap.set("n", "<F9>7", "<cmd>tabn 7<CR>")
keymap.set("n", "<F9>8", "<cmd>tabn 8<CR>")
keymap.set("n", "<F9>9", "<cmd>tabn 9<CR>")
keymap.set("n", "<F9>n", "<cmd>tabnext<CR>")
keymap.set("n", "<F9>b", "<cmd>tabprev<CR>")
keymap.set("n", "<F9>k", "<cmd>tabnext<CR>")
keymap.set("n", "<F9>j", "<cmd>tabprev<CR>")

keymap.set("n", "<Space>1", "<cmd>tabn 1<CR>")
keymap.set("n", "<Space>2", "<cmd>tabn 2<CR>")
keymap.set("n", "<Space>3", "<cmd>tabn 3<CR>")
keymap.set("n", "<Space>4", "<cmd>tabn 4<CR>")
keymap.set("n", "<Space>5", "<cmd>tabn 5<CR>")
keymap.set("n", "<Space>6", "<cmd>tabn 6<CR>")
keymap.set("n", "<Space>7", "<cmd>tabn 7<CR>")
keymap.set("n", "<Space>8", "<cmd>tabn 8<CR>")
keymap.set("n", "<Space>9", "<cmd>tabn 9<CR>")
keymap.set("n", "<Tab>k", "<cmd>tabnext<CR>")
keymap.set("n", "<Tab>j", "<cmd>tabprev<CR>")

---------------------------------------------
---------------------------------------------
-- MOVE
---------------------------------------------
---------------------------------------------
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("i", "<F1>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>,", ";", { noremap = true, silent = true })

---------------------------------------------
---------------------------------------------
-- LSP
---------------------------------------------
---------------------------------------------
keymap.set("n", "<leader>rl", "<cmd>lua vim.diagnostic.reset()<CR>")
keymap.set("n", "<A>1", "<cmd>tabn 1<CR>")

---------------------------------------------
---------------------------------------------
-- NEOVIDE
---------------------------------------------
---------------------------------------------
vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

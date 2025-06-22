-- Clear jumps on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("clearjumps")
  end,
})

-- Memory optimization: Clear registers periodically
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Clear large registers to prevent memory leaks
    for i = 0, 9 do
      vim.fn.setreg(tostring(i), "")
    end
    vim.fn.setreg('"', "")
    vim.fn.setreg("*", "")
    vim.fn.setreg("+", "")
  end,
})

-- Optimize large file handling
vim.api.nvim_create_autocmd("BufReadPre", {
  callback = function(args)
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > 1048576 then -- 1MB
      vim.b[args.buf].large_buf = true
      -- Disable expensive features for large files
      vim.cmd("syntax off")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.swapfile = false
      vim.opt_local.undofile = false
    end
  end,
})

-- Project-based session management
local function get_session_file()
  local cwd = vim.fn.getcwd()
  local session_dir = vim.fn.stdpath("data") .. "/sessions"
  vim.fn.mkdir(session_dir, "p")
  return session_dir .. "/" .. vim.fn.substitute(cwd, "/", "%%", "g") .. ".vim"
end

-- Auto-save session on exit for projects with git
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.fn.isdirectory(".git") == 1 then
      local session_file = get_session_file()
      vim.cmd("mksession! " .. session_file)
    end
  end,
})

-- Auto-load session for git projects
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Only auto-load if no arguments passed to nvim
    if vim.fn.argc() == 0 and vim.fn.isdirectory(".git") == 1 then
      local session_file = get_session_file()
      if vim.fn.filereadable(session_file) == 1 then
        vim.cmd("source " .. session_file)
      end
    end
  end,
})

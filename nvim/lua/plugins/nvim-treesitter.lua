return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  config = function()
    local status, ts = pcall(require, "nvim-treesitter.configs")
    if not status then
      return
    end

    ts.setup({
      modules = {},
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      -- highlight = {
      -- 	enable = true,
      -- 	additional_vim_regex_highlighting = true,
      -- 	use_languagetree = true,
      -- 	disable = {},
      -- },

      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 50 * 1024 -- 50 KB for better memory usage
          local max_lines = 5000
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
          -- Disable for files with too many lines
          if vim.api.nvim_buf_line_count(buf) > max_lines then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "sql" },
        -- disable = { "python", "yaml" },
        -- disable = { "norg" },
      },
      ensure_installed = {
        "lua",
        "python",
        "go",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "yaml",
        "toml",
        "markdown",
        "bash",
        "dockerfile",
        "html",
        "css",
      },
      autotag = {
        enable = true,
      },
      -- context_commentstring = {
      -- 	enable = true,
      -- },
    })
  end,
}

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
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
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
        "tsx",
        "toml",
        "json",
        "yaml",
        "css",
        "html",
        "lua",
        "python",
        "go",
        "dockerfile",
        "javascript",
        "markdown",
        "lua",
        "bash",
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

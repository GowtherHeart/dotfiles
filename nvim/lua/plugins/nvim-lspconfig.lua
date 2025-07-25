return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local status, nvim_lsp = pcall(require, "lspconfig")
    if not status then
      return
    end

    local util = require("lspconfig/util")
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "cd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        vim.keymap.set("n", "<leader>cf", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    local border = {
      { "┌", "FloatBorder" },
      { "─", "FloatBorder" },
      { "┐", "FloatBorder" },
      { "│", "FloatBorder" },
      { "┘", "FloatBorder" },
      { "─", "FloatBorder" },
      { "└", "FloatBorder" },
      { "│", "FloatBorder" },
    }
    -- LSP settings (for overriding per client)
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Enhanced LSP caching
    local default_config = {
      capabilities = lsp_capabilities,
      handlers = handlers,
      flags = {
        debounce_text_changes = 150,
        allow_incremental_sync = true,
      },
    }

    nvim_lsp.pyright.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        pyright = { disableOrganizeImports = true },
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            ignore = { "*" },
            useLibraryCodeForTypes = false, -- Better performance
            autoImportCompletions = true,
          },
        },
      },
    }))

    -- Language servers with caching
    nvim_lsp.gopls.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        gopls = {
          experimentalPostfixCompletions = true,
          analyses = { unusedparams = true },
          staticcheck = true,
          gofumpt = true,
        },
      },
    }))

    nvim_lsp.rust_analyzer.setup(vim.tbl_deep_extend("force", default_config, {
      settings = {
        ["rust-analyzer"] = {
          diagnostics = { enable = false },
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" },
        },
      },
    }))

    nvim_lsp.bashls.setup(default_config)
    nvim_lsp.jsonls.setup(default_config)
    nvim_lsp.marksman.setup(vim.tbl_deep_extend("force", default_config, {
      root_dir = util.root_pattern(".git", ".marksman.toml"),
    }))
  end,
}

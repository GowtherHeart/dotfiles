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

    nvim_lsp.pyright.setup({
      handlers = handlers,
      settings = {
        pyright = { disableOrganizeImports = true },
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            ignore = { "*" },
          },
        },
      },
      capabilities = lsp_capabilities,
    })
    -- Language servers
    nvim_lsp.gopls.setup({ handlers = handlers, capabilities = lsp_capabilities })
    nvim_lsp.rust_analyzer.setup({
      handlers = handlers,
      capabilities = lsp_capabilities,
      settings = { ["rust-analyzer"] = { diagnostics = { enable = false } } },
    })
    nvim_lsp.bashls.setup({ handlers = handlers, capabilities = lsp_capabilities })
    nvim_lsp.jsonls.setup({ handlers = handlers, capabilities = lsp_capabilities })
    nvim_lsp.marksman.setup({
      handlers = handlers,
      capabilities = lsp_capabilities,
      root_dir = util.root_pattern(".git", ".marksman.toml"),
    })
  end,
}

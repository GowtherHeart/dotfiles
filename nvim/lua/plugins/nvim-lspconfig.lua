return {
  "neovim/nvim-lspconfig",
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

    -- local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

    -- The main servers
    local root_files = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      "pyrightconfig.json",
      ".git",
    }

    nvim_lsp.pyright.setup({
      -- root_dir = util.root_pattern(unpack(root_files)),
      filetypes = { "python" },
      single_file_support = true,
      cmd = { "pyright-langserver", "--stdio" },
      handlers = handlers,
      -- handlers = {
      -- 	["textDocument/publishDiagnostics"] = function() end,
      -- },
      settings = {
        pyright = {
          disableOrganizeImports = true,
        },
        python = {
          analysis = {
            -- autoSearchPaths = true,

            -- diagnosticMode = "workspace",

            diagnosticMode = "openFilesOnly",
            -- useLibraryCodeForTypes = true,
            -- typeCheckingMode = "on",

            -- typeCheckingMode = "off",
            -- reportUnusedVariable = "off",

            ignore = { "*" },
          },
        },
      },
      capabilities = lsp_capabilities,
    })
    nvim_lsp.gopls.setup({
      handlers = handlers,
    })

    nvim_lsp.rust_analyzer.setup({
      settings = {
        ["rust-analyzer"] = {
          diagnostics = {
            enable = false,
          },
        },
      },
    })
    nvim_lsp.bashls.setup({})
    nvim_lsp.jsonls.setup({})
    -- nvim_lsp.postgres_lsp.setup{}
    nvim_lsp.marksman.setup({
      cmd = { "marksman", "server" },
      filetypes = { "markdown" },
      single_file_support = true,
      root_dir = util.root_pattern(".git", ".marksman.toml"),
    })
  end,
}

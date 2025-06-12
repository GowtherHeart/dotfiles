return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")
      local Path = require("plenary.path")

      -- Setup Harpoon with custom data path
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
          key = function()
            -- Use project-specific data directory
            local cwd = vim.loop.cwd()
            return cwd
          end,
        },
      })

      -- Helper functions for preset management
      local M = {}

      -- Get the project-specific harpoon directory
      function M.get_harpoon_dir()
        local cwd = vim.loop.cwd()
        return Path:new(cwd) / ".local" / "harpoon"
      end

      -- Ensure harpoon directory exists
      function M.ensure_harpoon_dir()
        local dir = M.get_harpoon_dir()
        if not dir:exists() then
          dir:mkdir({ parents = true })
        end
        return dir
      end

      -- Get presets metadata file path
      function M.get_presets_file()
        return M.ensure_harpoon_dir() / "__preset_array__.json"
      end

      -- Get preset data file path
      function M.get_preset_file(preset_name)
        return M.ensure_harpoon_dir() / (preset_name .. ".json")
      end

      -- Load presets metadata
      function M.load_presets()
        local presets_file = M.get_presets_file()
        if presets_file:exists() then
          local content = presets_file:read()
          local ok, data = pcall(vim.json.decode, content)
          if ok and data then
            return data
          end
        end
        -- Return default structure
        return {
          current = "default",
          presets = { "default" },
        }
      end

      -- Save presets metadata
      function M.save_presets(data)
        local presets_file = M.get_presets_file()
        presets_file:write(vim.json.encode(data), "w")
      end

      -- Initialize preset system
      function M.init()
        local data = M.load_presets()
        _G.current_harpoon_preset = data.current or "default"

        -- Ensure default preset exists
        if not vim.tbl_contains(data.presets, "default") then
          table.insert(data.presets, 1, "default")
          M.save_presets(data)
        end
      end

      -- Create new preset
      function M.create_preset(name)
        if not name or name == "" then
          vim.notify("Preset name cannot be empty", vim.log.levels.ERROR)
          return
        end

        local data = M.load_presets()
        if not vim.tbl_contains(data.presets, name) then
          table.insert(data.presets, name)
          M.save_presets(data)

          -- Create empty preset file
          local preset_file = M.get_preset_file(name)
          if not preset_file:exists() then
            preset_file:write(vim.json.encode({ items = {} }), "w")
          end

          vim.notify("Created preset: " .. name, vim.log.levels.INFO)
        else
          vim.notify("Preset already exists: " .. name, vim.log.levels.WARN)
        end
      end

      -- Switch to preset
      function M.switch_preset(name)
        local data = M.load_presets()
        if vim.tbl_contains(data.presets, name) then
          _G.current_harpoon_preset = name
          data.current = name
          M.save_presets(data)

          -- Load the preset data
          local preset_file = M.get_preset_file(name)
          if preset_file:exists() then
            -- Force Harpoon to reload from the custom file
            local list = harpoon:list(name)
            local preset_data = preset_file:read()
            local ok, decoded = pcall(vim.json.decode, preset_data)
            if ok and decoded and decoded.items then
              -- Clear existing items first
              while #list.items > 0 do
                table.remove(list.items)
              end
              -- Add items from saved preset
              for _, item in ipairs(decoded.items) do
                table.insert(list.items, item)
              end
            end
          end

          vim.notify("Switched to preset: " .. name, vim.log.levels.INFO)
        else
          vim.notify("Preset not found: " .. name, vim.log.levels.ERROR)
        end
      end

      -- Save current preset data
      function M.save_current_preset()
        local preset_name = _G.current_harpoon_preset or "default"
        local list = harpoon:list(preset_name)
        local preset_file = M.get_preset_file(preset_name)

        -- Ensure list.items exists
        if not list.items then
          list.items = {}
        end

        local data = {
          items = list.items,
        }

        preset_file:write(vim.json.encode(data), "w")
      end

      -- Create a wrapper to auto-save after operations
      local function with_save(fn)
        return function(...)
          local result = fn(...)
          vim.defer_fn(function()
            M.save_current_preset()
          end, 50)
          return result
        end
      end

      -- Initialize the preset system
      M.init()

      -- Keymaps
      -- Add to current preset
      vim.keymap.set("n", "<leader>a", function()
        local list = harpoon:list(_G.current_harpoon_preset)
        list:add()
        M.save_current_preset()
        vim.notify("Added to " .. _G.current_harpoon_preset, vim.log.levels.INFO)
      end, { desc = "Add file to current Harpoon preset" })

      -- Toggle quick menu for current preset
      vim.keymap.set("n", "<C-e>", function()
        local list = harpoon:list(_G.current_harpoon_preset)
        harpoon.ui:toggle_quick_menu(list)
      end, { desc = "Toggle Harpoon quick menu" })

      -- Select files from current preset
      vim.keymap.set("n", "<C-h>", function()
        harpoon:list(_G.current_harpoon_preset):select(1)
      end, { desc = "Harpoon select 1" })

      vim.keymap.set("n", "<C-t>", function()
        harpoon:list(_G.current_harpoon_preset):select(2)
      end, { desc = "Harpoon select 2" })

      vim.keymap.set("n", "<C-s>", function()
        harpoon:list(_G.current_harpoon_preset):select(3)
      end, { desc = "Harpoon select 3" })

      vim.keymap.set("n", "<C-g>", function()
        harpoon:list(_G.current_harpoon_preset):select(4)
      end, { desc = "Harpoon select 4" })

      -- Navigate in current preset
      vim.keymap.set("n", "<C-p>", function()
        harpoon:list(_G.current_harpoon_preset):prev()
      end, { desc = "Harpoon previous" })

      vim.keymap.set("n", "<C-n>", function()
        harpoon:list(_G.current_harpoon_preset):next()
      end, { desc = "Harpoon next" })

      -- Telescope integration for preset selection
      vim.keymap.set("n", ";;", function()
        local data = M.load_presets()
        local presets = data.presets or { "default" }

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        local previewers = require("telescope.previewers")

        local theme = require("telescope.themes")

        pickers
          .new(
            theme.get_dropdown({
              winblend = 0,
              border = true,
              shorten_path = false,
              prompt_title = "",
              preview_title = "",
              borderchars = {
                { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
              },
            }),
            {
              prompt_title = "Harpoon Presets (Current: " .. _G.current_harpoon_preset .. ")",
              finder = finders.new_table({
                results = presets,
                entry_maker = function(preset)
                  return {
                    value = preset,
                    display = preset == _G.current_harpoon_preset and "● " .. preset or "  " .. preset,
                    ordinal = preset,
                  }
                end,
              }),
              sorter = conf.generic_sorter({}),
              previewer = previewers.new_buffer_previewer({
                title = "Preset Files",
                define_preview = function(self, entry, status)
                  local preset_file = M.get_preset_file(entry.value)
                  if preset_file:exists() then
                    local content = preset_file:read()
                    local ok, decoded = pcall(vim.json.decode, content)
                    if ok and decoded and decoded.items then
                      local lines = { "Files in preset '" .. entry.value .. "':", "" }
                      for i, item in ipairs(decoded.items or {}) do
                        if item.value then
                          table.insert(lines, string.format("%d. %s", i, item.value))
                        end
                      end
                      if #decoded.items == 0 then
                        table.insert(lines, "(empty)")
                      end
                      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                    end
                  else
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, { "Preset file not found" })
                  end
                end,
              }),
              attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                  actions.close(prompt_bufnr)
                  local selection = action_state.get_selected_entry()
                  if selection then
                    M.switch_preset(selection.value)
                    -- Open the quick menu after switching
                    harpoon.ui:toggle_quick_menu(harpoon:list(selection.value))
                  end
                end)

                -- Map <C-n> to create new preset
                map("i", "<C-n>", function()
                  actions.close(prompt_bufnr)
                  vim.ui.input({ prompt = "New preset name: " }, function(name)
                    if name and name ~= "" then
                      M.create_preset(name)
                      M.switch_preset(name)
                    end
                  end)
                end)

                -- Map <C-d> to delete preset (not default)
                map("i", "<C-d>", function()
                  local selection = action_state.get_selected_entry()
                  if selection and selection.value ~= "default" then
                    vim.ui.select({ "Yes", "No" }, {
                      prompt = "Delete preset '" .. selection.value .. "'?",
                    }, function(choice)
                      if choice == "Yes" then
                        actions.close(prompt_bufnr)
                        local data = M.load_presets()
                        -- Remove from presets list
                        for i, preset in ipairs(data.presets) do
                          if preset == selection.value then
                            table.remove(data.presets, i)
                            break
                          end
                        end
                        -- Switch to default if deleting current
                        if _G.current_harpoon_preset == selection.value then
                          _G.current_harpoon_preset = "default"
                          data.current = "default"
                        end
                        M.save_presets(data)
                        -- Delete preset file
                        local preset_file = M.get_preset_file(selection.value)
                        if preset_file:exists() then
                          preset_file:rm()
                        end
                        vim.notify("Deleted preset: " .. selection.value, vim.log.levels.INFO)
                      end
                    end)
                  else
                    vim.notify("Cannot delete default preset", vim.log.levels.WARN)
                  end
                end)

                return true
              end,
            }
          )
          :find()
      end, { desc = "Select Harpoon preset" })

      -- Add file to specific preset via Telescope
      vim.keymap.set("n", "<leader>ha", function()
        local data = M.load_presets()
        local presets = data.presets or { "default" }

        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")

        pickers
          .new({}, {
            prompt_title = "Add to Harpoon Preset",
            finder = finders.new_table({
              results = presets,
              entry_maker = function(preset)
                return {
                  value = preset,
                  display = preset == _G.current_harpoon_preset and "● " .. preset or "  " .. preset,
                  ordinal = preset,
                }
              end,
            }),
            sorter = conf.generic_sorter({}),
            attach_mappings = function(prompt_bufnr, map)
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  local list = harpoon:list(selection.value)
                  list:add()
                  -- Save the specific preset
                  local preset_file = M.get_preset_file(selection.value)
                  if not list.items then
                    list.items = {}
                  end
                  preset_file:write(vim.json.encode({ items = list.items }), "w")
                  vim.notify("Added to preset: " .. selection.value, vim.log.levels.INFO)
                end
              end)
              return true
            end,
          })
          :find()
      end, { desc = "Add file to Harpoon preset via Telescope" })

      -- Commands
      vim.api.nvim_create_user_command("HarpoonPreset", function(opts)
        if opts.args ~= "" then
          M.create_preset(opts.args)
        else
          vim.notify("Please provide a preset name", vim.log.levels.ERROR)
        end
      end, { nargs = 1, desc = "Create new Harpoon preset" })

      vim.api.nvim_create_user_command("HarpoonSwitch", function(opts)
        if opts.args ~= "" then
          M.switch_preset(opts.args)
        else
          -- Show preset picker if no args
          vim.cmd("normal ;;")
        end
      end, { nargs = "?", desc = "Switch Harpoon preset" })

      vim.api.nvim_create_user_command("HarpoonCurrent", function()
        vim.notify("Current preset: " .. _G.current_harpoon_preset, vim.log.levels.INFO)
      end, { desc = "Show current Harpoon preset" })

      vim.api.nvim_create_user_command("HarpoonAdd", function(opts)
        local preset_name = opts.args ~= "" and opts.args or _G.current_harpoon_preset
        local list = harpoon:list(preset_name)
        list:add()
        -- Save the specific preset
        local preset_file = M.get_preset_file(preset_name)
        if not list.items then
          list.items = {}
        end
        preset_file:write(vim.json.encode({ items = list.items }), "w")
        vim.notify("Added to preset: " .. preset_name, vim.log.levels.INFO)
      end, { nargs = "?", desc = "Add file to Harpoon preset" })

      -- Auto-save on certain events
      vim.api.nvim_create_autocmd({ "BufLeave", "VimLeavePre" }, {
        callback = function()
          M.save_current_preset()
        end,
      })

      -- Load preset data on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(function()
            M.switch_preset(_G.current_harpoon_preset)
          end, 100)
        end,
      })
    end,
  },
}

local llm_defaults = {
  default = "llama_cpp",
  ollama_url = "http://127.0.0.1:11434",
  llama_cpp_url = "http://127.0.0.1:11444",
  model = "qwen3-coder-next_q4xl",
  prompt_context = 1000,
  rules = {
    ".clinerules", ".cursorrules", ".goosehints", ".rules", ".windsurfrules",
    ".github/copilot-instructions.md", "AGENT.md", "AGENTS.md",
    { path = "CLAUDE.md", parser = "claude" },
    { path = "CLAUDE.local.md", parser = "claude" },
    { path = _G["myconfigpath"] .. "/intelligence/default.md", parser = "codecompanion" },
  }
}

local ai_utils = require("myconfig.ai_utils")

return {
  { import = "astrocommunity.ai.codecompanion-nvim" },
  { import = "astrocommunity.editing-support.vector-code-nvim" },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        http = {
          opts = {
            show_presets = false,
          },
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = { default = llm_defaults.model, },
              },
              env = { url = llm_defaults.ollama_url, },
            })
          end,
          llama_cpp = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              schema = {
                model = { default = llm_defaults.model },
              },
              env = { url = llm_defaults.llama_cpp_url, },
              handlers = {
                form_messages = ai_utils.llama_cpp_form_messages,
                parse_message_meta = ai_utils.llama_cpp_parse_message_meta,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = llm_defaults.default,
          opts = {
            system_prompt = function ()
              local lines = vim.fn.readfile(_G["myconfigpath"] .. "/intelligence/system-prompt.txt")
              return table.concat(lines, "\n");
            end,
          },
          tools = {
            opts = { },
          },
        },
        inline = {
          adapter = llm_defaults.default
        },
      },
      rules = {
        default = {
          description = "Default rules (+ use project-specific, if any)",
          files = llm_defaults.rules,
        },
        caveman = {
          description = "Caveman (brief) mode",
          files = vim.tbl_deep_extend('force', llm_defaults.rules, {
            { path = _G["myconfigpath"] .. "/intelligence/caveman.md", parser = "codecompanion" },
          }),
        },
        opts = {
          chat = { autoload = "caveman", enabled = true },
        },
      },
      opts = {
        log_level = "DEBUG",
        show_model_choices = false,
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            auto_save = true,
            expiration_days = 0, -- do not delete
            auto_generate_title = true,
            continue_last_chat = false,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          }
        },
        spinner = {
          enabled = true,
          opts = {
            style = "fidget",
          },
        },
      },
      mcp = {
        servers = {
          ["vectorcode"] = {
            cmd = { "vectorcode-mcp-server", },
          },
        },
        opts = {
          -- default_servers = { "vectorcode" },
        },
      },
    },
    dependencies = {
      "ravitemer/codecompanion-history.nvim",
      "lalitmee/codecompanion-spinners.nvim",
      "j-hui/fidget.nvim",
    }
  },
  {
    "ravitemer/codecompanion-history.nvim",
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        if not opts.mappings then opts.mappings = {} end
        opts.mappings.n = opts.mappings.n or {}
        opts.mappings.n["<Leader>Ah"] = { "<cmd>CodeCompanionHistory<cr>", desc = "Chat History" }
        opts.mappings.n[";i"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion" }
        opts.mappings.v[";i"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Code Companion" }
        opts.mappings.n[";I"] = { "<cmd>CodeCompanionHistory<cr>", desc = "Code Companion Chat History" }

        opts.autocmds.ccompanion_persist_model = { {
          event = "User",
          desc = "Persist CodeCompanion model on chat open/close events",
          pattern = "CodeCompanionChatCreated",
          callback = function(args)
            local chat = require("codecompanion").buf_get_chat(args.data.bufnr)
            -- load stored model at creation
            local saved = ai_utils.cc_persist.load()
            if saved then
              chat:change_model({ model = saved.model })
            end
            -- add callback to save the current model
            chat:add_callback("on_closed", function(c, info)
              local data = { model = chat.settings.model }
              ai_utils.cc_persist.save(data)
            end)
          end
        } }
      end,
    },
  },
  {
    -- sharedserver: for sharing MCP Companion between instances
    "georgeharker/sharedserver",
    build = "cargo install --path rust",
    lazy = false,
  },
  {
    "georgeharker/mcp-companion",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "olimorris/codecompanion.nvim",
      "georgeharker/sharedserver",
    },
    build = "cd bridge && uv sync --frozen",
    opts = {
      bridge = {
        config = _G["myconfigpath"] .. "/intelligence/mcp.json"
      },
      auto_approve = function(tool_name, server_name, ctx)
        -- auto-approve all read-only tools
        if tool_name:match("^get_") or tool_name:match("^list_") then
          return true
        end
        return false
      end,
      ui = {
        enabled = true, width = 0.5, height = 0.5, border = "rounded",
      },
      log = { level = "debug", notify = "error" },
    }
  },
  { "Davidyz/VectorCode",
    build = function()
      if not vim.fn.executable "uv" then error "The VectorCode pack requires uv installed" end
    end
  },
}

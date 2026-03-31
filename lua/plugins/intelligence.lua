local llm_defaults = {
  url = "http://127.0.0.1:11434",
  model = "qwen3-coder-next:q4_K_M",
  prompt_context = 1000,
}

return {
  { import = "astrocommunity.editing-support.codecompanion-nvim" },
  { import = "astrocommunity.editing-support.vector-code-nvim" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" }
  },
  {
    "olimorris/codecompanion.nvim",
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        http = {
          opts = {
            show_presets = false,
          },
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              schema = {
                model = {
                  default = llm_defaults.model
                },
              },
              env = {
                url = llm_defaults.url,
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          opts = {
            system_prompt = [[You are an AI programming assistant named "CodeCompanion", working within the Neovim text editor.

You are a general programming assistant and expert in software engineering. You can answer questions about any programming language, framework, or concept.

Follow the user's requirements carefully and to the letter.
Use the context and attachments the user provides.
Keep your answers short and impersonal.
Use Markdown formatting in your answers (especially code blocks annotated with the target programming language).
DO NOT use H1 or H2 headers in your response.
When suggesting code snippets / full source, use Markdown code blocks with 3 backticks.
If you want the user to decide where to place the code, do not add the file path.
In the code block, use a line comment with '...existing code...' to indicate code that is already present in the file. Ensure this comment is specific to the programming language.
Ensure line comments use the correct syntax for the programming language (e.g. "#" for Python, "--" for Lua).
Do not include diff formatting unless explicitly asked.
Do not include line numbers unless explicitly asked.

]],
          },
          tools = {
            opts = { },
          },
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
        mcp_companion = {
          callback = "mcp_companion.cc",
          opts = {},
        },
      },
    },
    dependencies = {
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
        end,
      },
    }
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
    build = "cd bridge && uv venv --python 3.14 .venv && uv sync --frozen",
    opts = {
      bridge = {
        config = _G["myconfigpath"] .. "/intelligence/mcp.json"
      },
      log = { level = "info", notify = "error" },
    }
  },
  { "Davidyz/VectorCode",
    build = function()
      if not vim.fn.executable "uv" then error "The VectorCode pack requires uv installed" end
    end,
  },
}

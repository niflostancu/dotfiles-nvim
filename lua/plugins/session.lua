-- Session management plugins & customizations

local dirsess_opts = function()
  -- return currently loaded session dir if any, otherwise the working directory
  local Path = require("plenary.path")
  local session_dir = Path:new(vim.fn.getcwd()):absolute()
  local session_info = require("resession").get_current_session_info()
  if session_info and session_info["dir"] then
    session_dir = session_info["dir"]
  end
  return { dir = session_dir }
end

return {
  {
    "stevearc/resession.nvim",
    config = function(_, opts)
      -- patch resession.util.get_session_dir to allow absolute paths
      local resession_util = require("resession.util")
      resession_util.get_session_dir = function(dirname)
        dirname = dirname or require("resession.config").dir
        if dirname and dirname:find("^/") then
          -- print("sess: absolute: ", dirname)
          return dirname
        end
        local files = require("resession.files")
        dirname = files.get_stdpath_filename("data", dirname)
        -- print("sess: stdpath: ", dirname)
        return dirname
      end
      -- remove from opts
      opts.extensions["astrocore"] = nil
      require "resession".setup(opts)
    end,
    opts = {
      autosave = {
        enabled = true,
        -- How often to save (in seconds)
        interval = 60,
        -- Notify when autosaved
        notify = false,
      },
      extensions = {
        hbac = {}, -- persist pinned buffers
      },
    },
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>SS"] = {
            function()
              local diropt = dirsess_opts()
              require("resession").save(".resession", diropt)
              require("notify")("Session saved to " .. diropt["dir"])
            end,
            desc = "Save dirsession",
          }
          maps.n["<Leader>SD"] =
          { function() require("resession").delete(nil, dirsess_opts()) end, desc = "Delete a dirsession" }
          maps.n["<Leader>SF"] =
          { function() require("resession").load(nil, dirsess_opts()) end, desc = "Load a dirsession" }
          maps.n["<Leader>S."] = {
            function() require("resession").load(".resession", dirsess_opts()) end,
            desc = "Load current dirsession",
          }
        end
      }
    }
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
      local get_icon = require("astroui").get_icon
      opts.section.buttons.val = {
        opts.button("n", get_icon("FileNew", 2, true) .. "New File  ", "<Cmd>ene!<CR>"),
        opts.button("f", get_icon("Search", 2, true) .. "Find File  ", "<Cmd>Telescope find_files<CR>"),
        opts.button("F", get_icon("DefaultFile", 2, true) .. "Recents  ", "<Cmd>Telescope oldfiles<CR>"),
        opts.button("g", get_icon("WordFile", 2, true) .. "Find Word  ", "<Cmd>Telescope live_grep<CR>"),
        opts.button("s", get_icon('Refresh', 2, true) .. " Load dir session", function()
          require("resession").load(".resession", dirsess_opts())
        end),
        opts.button("q", get_icon('TabClose', 2, true) .. " Quit", "<Cmd>:qa!<CR>")
      }
    end,
  },
  -- plugin to close unedited buffers when the list becomes too large
  {
    'axkirillov/hbac.nvim',
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = {
          extensions = {
            hbac = {},
          },
        }
      },
    },
    opts = {
      autoclose = false,
      threshold = 30, -- number of buffers to trigger
      close_command = function(bufnr)
        vim.api.nvim_buf_delete(bufnr, {})
      end,
      close_buffers_with_windows = false,
      -- telescope = {},
    },
    config = function (_, opts)
      require("hbac").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        -- ignore pinned buffers from early retirement!
        -- https://github.com/axkirillov/hbac.nvim/issues/23
        callback = function(cb_opts)
          local bufnr = cb_opts.data.bufnr
          local state = cb_opts.data.state
          vim.api.nvim_buf_set_var(bufnr, "ignore_early_retirement", 
            state == "pinned")
        end,
        pattern = "HBACPinned",
      })
    end
  },
  -- early buffers retirement (after X minutes of inactivity)
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    config = true,
    opts = {
      retirementAgeMins = 180,
      minimumBufferNum = 20,
      ignoreAltFile = true,
    },
  },
}

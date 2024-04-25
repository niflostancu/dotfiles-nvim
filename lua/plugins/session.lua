-- Session management plugins & customizations

local dirsess_opts = function()
  -- return current working directory
  local Path = require("plenary.path")
  local session_dir = Path:new(vim.fn.getcwd()):absolute()
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
          print("sess: absolute: ", dirname)
          return dirname
        end
        local files = require("resession.files")
        dirname = files.get_stdpath_filename("data", dirname)
          print("sess: stdpath: ", dirname)
        return dirname
      end
      require "resession".setup(opts)
    end,
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          maps.n["<Leader>SS"] = {
            function() require("resession").save(".resession", dirsess_opts()) end,
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
  }
}

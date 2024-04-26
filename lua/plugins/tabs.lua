-- Tab workflow plugins & customizations

return {
  -- disable heirline's tabline
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts) opts.tabline = nil end,
  },
  {
    "nanozuki/tabby.nvim",
    config = function()
      local function tab_modified(tab, mod, not_mod)
        local wins = require("tabby.module.api").get_tab_wins(tab)
        for _, x in pairs(wins) do
          if vim.bo[vim.api.nvim_win_get_buf(x)].modified then
            return mod end
        end return not_mod
      end
      local theme = {
        fill = 'TabLine', head = 'HeirlineVisual', tail = 'TabLine',
        current_tab = 'TabLineSel', inactive_tab = 'TabLineFill',
      }
      local get_tab_name = function(tab)
        local name = tab.name()
        if not (name == nil or name == '') then return name end
        local ok, twd = pcall(vim.fn.getcwd, 0, tab.id)
        if not ok then return "<???>" end
        return vim.fn.fnamemodify(twd, ":t")
      end
      require('tabby.tabline').set(function(line)
        return {
          {
            { '  ', hl = theme.head },
            line.sep('', theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.inactive_tab
            local num_hl = tab.is_current() and theme.fill or theme.current_tab
            local sep_l = line.sep('', hl, theme.fill)
            local sep_r = line.sep('', hl, theme.fill)
            if ((line.api.get_current_tab() - tab.number()) > 0) then sep_l = '' end
            if ((tab.number() - line.api.get_current_tab()) > 0) then sep_r = '' end
            return {
              sep_l, line.sep(' ', hl, hl),
              -- nf-md-numeric_<X>_circle for tab ID
              line.sep(vim.fn.nr2char(0xf0ca0 - 2 + 2 * tab.number()), num_hl, hl),
              line.sep(' ', hl, hl),
              get_tab_name(tab), tab_modified(tab.id, "󰐗 ", " "),
              sep_r, hl = hl, margin = '',
            }
          end),
          line.spacer(),
          hl = theme.fill,
        }
      end, {
          tab_name = {
            name_fallback = function() return '' end
          },
        }
      )
    end,
    dependencies = {
      {'rebelot/heirline.nvim'},
      {'nvim-tree/nvim-web-devicons', lazy = true}
    },
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      opts.autocmds.restore_prev_tab = { {
        event = "TabLeave",
        desc = "Save previous tab as global variable for quick restoration using '<Leader>t'",
        pattern = "*",
        callback = function() vim.g.lasttab = vim.fn.tabpagenr() end,
      } };
      opts.mappings.n["<Leader>t"] = {
        desc = "Switch to previous (last used) tab",
        function() vim.cmd("tabn " .. (vim.g.lasttab or 1)) end,
      }
      -- navigate tabs with `H` and `L`
      opts.mappings.n["H"] = { "<Cmd>tabprevious<CR>", desc = "Next buffer" }
      opts.mappings.n["L"] = { "<Cmd>tabnext<CR>", desc = "Previous buffer" }

      -- go to tab by number
      for i = 1, 9 do
        opts.mappings.n["g" .. i] = {
          function()
            if i <= vim.fn.tabpagenr('$') then
              vim.cmd("tabn " .. i)
            end
          end,
          desc = "Switch to tab " .. i,
        }
      end
      return opts
    end
  },
}

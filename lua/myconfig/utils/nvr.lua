local M = {}

function M.remote_open(path)
  local res = os.execute(string.format("sh -c 'nvr --nostart --remote-silent \"%s\"'", path))
  if (res ~= 0) then
    print(string.format("nvr failed with %d", res))
  end
end

function M.remote_send(keys)
  local res = os.execute(string.format("sh -c 'nvr --nostart --remote-send \"%s\"'", keys))
  if (res ~= 0) then
    print(string.format("nvr failed with %d", res))
  end
end


--- get input from the user and send it to the remote instance.
local function get_user_input()
  -- capture input.
  local ok, n = pcall(vim.fn.getchar)

  -- break on <C-c>
  if not ok then
    return false
  end
  -- break on <Esc>
  local c = (type(n) == "number" and vim.fn.nr2char(n) or n)
  local esc_code = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
  if c == esc_code then
    return false
  end

  -- send key to the remote instance
  M.remote_send(c)

  return true
end

local shade_overlay_win = nil
local function destroy_shade_overlay()
  if shade_overlay_win == nil then
    return
  end
  vim.api.nvim_win_close(shade_overlay_win.winid, true)
  shade_overlay_win = nil
end
local function create_shade_overlay()
  destroy_shade_overlay()
  local window = {}
  local config = {
    relative  = "editor",
    style     = "minimal",
    focusable = false,
    row    = 1,
    col    = 1,
    width  = vim.o.columns - 1,
    height = vim.o.lines - 1,
    zindex = 100,
  }
  window.wincfg = config
  window.bufid = vim.api.nvim_create_buf(false, true)
  window.winid = vim.api.nvim_open_win(window.bufid, true, config)
  shade_overlay_win = window

  vim.api.nvim_command("highlight! NVRShadeOverlay gui='nocombine' guibg=None")
  vim.api.nvim_win_set_option(window.winid, "winhighlight", "Normal:NVRShadeOverlay")
  vim.api.nvim_win_set_option(window.winid, "winblend", 30)
  vim.cmd("redraw")
end

function M.capture_mode()
  create_shade_overlay()
  print("NVR capture started!")
  local continue_mode = true
  while continue_mode do
    continue_mode = get_user_input()
  end
  destroy_shade_overlay()
  print("NVR capture stopped!")
end

return M

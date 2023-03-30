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

function M.capture_mode()
  local continue_mode = true
  while continue_mode do
    continue_mode = get_user_input()
  end
end

return M

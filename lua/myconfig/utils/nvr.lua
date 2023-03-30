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

return M

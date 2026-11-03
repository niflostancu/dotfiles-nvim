--[[
  Machine profile resolution.

  Order of precedence:
    1. $NVIM_PROFILE environment variable
    2. profile.local.lua in stdpath("config") (i.e. ~/.config/{NVIM_APPNAME}/,
       may live outside the repo, see misc/init-template.lua)
    3. local/profile.lua in the repo root (gitignored, per machine)
       Both are: a profile name string, or
       { profile = "name", extra = { feature = true, ... } }
    4. hostname map (`_hostnames` key in `profiles.lua`)
    5. default: "full"

  Usage in plugin files:
    local P = require "myconfig.profile"
    if not P.has("git") then return {} end
    -- P.has("lang.rust") for language features
]]

local profiles = require "profiles"

local M = {}

-- candidate paths, in priority order: config dir first, then repo root
local function local_paths()
  local root = _G["myconfigpath"] or vim.fn.stdpath("config")
  return {
    vim.fn.stdpath("config") .. "/profile.local.lua",
    vim.fs.normalize(root) .. "/profile.local.lua",
  }
end

local function read_local()
  for _, path in ipairs(local_paths()) do
    local f = io.open(path, "r")
    if f then
      local src = f:read("*a")
      f:close()
      local chunk = load(src, "@" .. path)
      if chunk then
        local ok, val = pcall(chunk)
        if ok then return val, path end
      end
    end
  end
  return nil
end

local function resolve()
  local env = vim.env.NVIM_PROFILE
  if env and profiles[env] then return env end

  local local_cfg, local_path = read_local()
  M.source = local_path
  if type(local_cfg) == "string" and profiles[local_cfg] then
    return local_cfg
  elseif type(local_cfg) == "table" and profiles[local_cfg.profile] then
    return local_cfg.profile, local_cfg.extra
  end

  local host = vim.fn.hostname()
  local hostnames = profiles._hostnames or {}
  if hostnames[host] then return hostnames[host] end

  return "full"
end

local name, extra = resolve()
local features = vim.tbl_extend("force", {}, profiles[name] or {}, extra or {})

M.name = name
M.features = features

-- has("git") or has("lang.rust")
function M.has(key)
  local t = features
  for part in string.gmatch(tostring(key), "([^%.]+)") do
    if type(t) ~= "table" then return false end
    t = t[part]
  end
  if t == true then return true end
  -- a (non-empty) table counts as enabled, e.g. `lang = { rust = true }`
  return type(t) == "table" and next(t) ~= nil or false
end

vim.api.nvim_create_user_command("MyProfile", function()
  local keys = {}
  for k in pairs(M.features) do table.insert(keys, k) end
  table.sort(keys)
  local src = M.source and (" (" .. M.source .. ")") or ""
  vim.notify("Profile: " .. M.name .. src .. " | " .. table.concat(keys, ", "), vim.log.levels.INFO)
end, {})

return M

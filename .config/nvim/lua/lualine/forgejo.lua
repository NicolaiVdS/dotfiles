local M = {}

local cache = {
  ci = nil,
  prs = nil,
  issues = nil,
  last_update = 0,
}

-- icons (nerd font)
local ci_icons = {
  success = "󰄬",
  failure = "󰅙",
  running = "󰑮",
  pen = "󰏤",
  unknown = "󰞋",
}

local icons = {
  prs = "",
  issues = "",
}

-- highlight groups
local function hl(name, fg)
  local base = vim.api.nvim_get_hl(0, { name = "StatusLine" })
  vim.api.nvim_set_hl(0, name, {
    fg = fg,
    bg = base.bg,
    bold = true,
  })
end

hl("ForgejoCISuccess", "#98c379")
hl("ForgejoCIFailure", "#e06c75")
hl("ForgejoCIRunning", "#e5c07b")
hl("ForgejoCIPending", "#61afef")
hl("ForgejoCIUnknown", "#7f8490")

local base = vim.api.nvim_get_hl(0, { name = "StatusLine" })
vim.api.nvim_set_hl(0, "ForgejoText", {
  fg = "#cdd6f4",
  bg = base.bg,
})

local ci_hl = {
  success = "ForgejoCISuccess",
  failure = "ForgejoCIFailure",
  running = "ForgejoCIRunning",
  pending = "ForgejoCIPending",
  unknown = "ForgejoCIUnknown",
}

-- detect git remote
local function get_git_remote()
  local handle = io.popen("git remote get-url origin 2>/dev/null")
  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then return nil end
  result = result:gsub("%s+", "")

  local host, user, repo

  host, user, repo = result:match("ssh://[^@]+@([^:]+):%d+/([^/]+)/([^/%.]+)")
  if host then return { host = host, user = user, repo = repo } end

  host, user, repo = result:match("git@([^:]+):([^/]+)/([^/%.]+)")
  if host then return { host = host, user = user, repo = repo } end

  host, user, repo = result:match("https://([^/]+)/([^/]+)/([^/%.]+)")
  if host then return { host = host, user = user, repo = repo } end

  return nil
end

-- generic forgejo request
local function forgejo_request(remote, path, callback)
  local token = vim.env.FORGEJO_TOKEN
  if not token then return end

  local url = string.format("https://%s/api/v1%s", remote.host, path)
  url = url:gsub("{user}", remote.user):gsub("{repo}", remote.repo)

  local cmd = string.format(
    'curl -s -H "Authorization: token %s" "%s"',
    token,
    url
  )

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then return end

      local text = table.concat(data, "")
      if text == "" then return end

      local ok, decoded = pcall(vim.fn.json_decode, text)
      if ok then
        callback(decoded)
      end
    end,
  })
end

-- refresh forgejo data
local function refresh()
  local remote = get_git_remote()
  if not remote then return end

  -- CI runs
  forgejo_request(remote, "/repos/{user}/{repo}/actions/runs", function(data)
    if data and data.workflow_runs then
      local runs = data.workflow_runs

      if #runs > 0 then
        table.sort(runs, function(a, b)
          return a.id > b.id
        end)

        local run = runs[1]

        local status = run.status
        if status == "completed" then
          status = run.conclusion or "unknown"
        end

        cache.ci = status
      end
    end

    vim.cmd("redrawstatus")
  end)

  -- PR count
  forgejo_request(remote, "/repos/{user}/{repo}/pulls?state=open&limit=50", function(data)
    if type(data) == "table" then
      cache.prs = #data
    end

    vim.cmd("redrawstatus")
  end)

  -- issue count
  forgejo_request(remote, "/repos/{user}/{repo}/issues?type=issues&state=open&limit=50", function(data)
    if type(data) == "table" then
      cache.issues = #data
    end

    vim.cmd("redrawstatus")
  end)

  cache.last_update = os.time()
end

-- lualine component
function M.component()
  local now = os.time()

  if now - cache.last_update > 30 then
    refresh()
  end

  local parts = {}

  if cache.ci then
    local icon = ci_icons[cache.ci] or ci_icons.unknown
    local hl = ci_hl[cache.ci] or ci_hl.unknown

    table.insert(parts, string.format("%%#%s#%s%%#Normal#", hl, icon))
  end

  if cache.prs then
    table.insert(parts,
      string.format(" %%#ForgejoText#%s %d%%#Normal#", icons.prs, cache.prs)
    )
  end

  if cache.issues then
    table.insert(parts,
      string.format(" %%#ForgejoText#%s %d%%#Normal#", icons.issues, cache.issues)
    )
  end

  if #parts == 0 then
    return ""
  end

  return table.concat(parts, " ")
end

return M

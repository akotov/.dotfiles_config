local M = {}

-- Change this to "qwen3:32b" to use the other local model.
M.model = "qwen3-coder-opencode:30b"

local endpoint = "http://localhost:11434/api/generate"

local function show_popup(lines, title)
  local width = math.min(math.max(50, math.floor(vim.o.columns * 0.7)), 100)
  local wrapped = {}
  for _, line in ipairs(lines) do
    if line == "" then
      table.insert(wrapped, "")
    else
      while #line > width - 2 do
        table.insert(wrapped, line:sub(1, width - 2))
        line = line:sub(width - 1)
      end
      table.insert(wrapped, line)
    end
  end

  local height = math.min(math.max(#wrapped, 1), math.max(3, vim.o.lines - 6))
  local buffer = vim.api.nvim_create_buf(false, true)
  vim.bo[buffer].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, wrapped)
  local window = vim.api.nvim_open_win(buffer, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " " .. title .. " ",
    title_pos = "center",
  })
  vim.wo[window].wrap = true
  vim.wo[window].cursorline = false

  local function close()
    if vim.api.nvim_win_is_valid(window) then
      vim.api.nvim_win_close(window, true)
    end
  end
  vim.keymap.set("n", "q", close, { buffer = buffer, nowait = true })
  vim.keymap.set("n", "<Esc>", close, { buffer = buffer, nowait = true })
end

local function show_error(message)
  show_popup({ "Ollama request failed:", "", message }, "Ollama error")
end

function M.ask()
  vim.ui.input({ prompt = "Ask about current file: " }, function(question)
    if not question or question:match("^%s*$") then
      return
    end

    local source = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
    local filename = vim.api.nvim_buf_get_name(0)
    local prompt = table.concat({
      "Answer the user's specific question about the source code below directly and concisely, preferably in 1-5 sentences.",
      "Avoid lengthy explanations unless requested. Include code only when useful.",
      "",
      "Question: " .. question,
      "",
      "File: " .. (filename ~= "" and filename or "[unnamed buffer]"),
      "```",
      source,
      "```",
    }, "\n")
    local payload = vim.json.encode({ model = M.model, prompt = prompt, stream = false })
    local stdout, stderr = {}, {}

    local job = vim.fn.jobstart({
      "curl",
      "--silent",
      "--show-error",
      "--fail-with-body",
      "--max-time",
      "120",
      "-X",
      "POST",
      endpoint,
      "-H",
      "Content-Type: application/json",
      "-d",
      payload,
    }, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, data)
        stdout = data or {}
      end,
      on_stderr = function(_, data)
        stderr = data or {}
      end,
      on_exit = function(_, code)
        vim.schedule(function()
          local body = table.concat(stdout, "\n")
          if code ~= 0 then
            local detail = table.concat(stderr, "\n")
            show_error(detail ~= "" and detail or "Could not connect to Ollama at " .. endpoint)
            return
          end

          local ok, response = pcall(vim.json.decode, body)
          if not ok or type(response) ~= "table" or type(response.response) ~= "string" or response.response == "" then
            show_error("Ollama returned an invalid or empty response.")
            return
          end
          show_popup(vim.split(response.response, "\n", { plain = true }), "Ollama")
        end)
      end,
    })
    if job <= 0 then
      show_error("Could not start curl. Ensure curl is installed.")
    end
  end)
end

return M

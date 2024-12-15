return {
  "oflisback/obsidian-bridge.nvim",
  opts = {
    obsidian_server_address = "http://127.0.0.1:27123",
    scroll_sync = false, -- See "Sync of buffer scrolling" section below
    -- cert_path = nil,     -- See "SSL configuration" section below
    warnings = true,     -- Show misconfiguration warnings. Recommended to keep this on unless you know what you're doing!
  },
  event = {
    "BufReadPre *.md",
    "BufNewFile *.md",
  },
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

return {
  {
    "saghen/blink.cmp",
    opts = {
      enabled = function()
        return vim.g.cmp_enabled ~= false
      end,
    },
  },
}

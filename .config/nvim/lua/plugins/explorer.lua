return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            -- Keep the explorer's current location when switching buffers.
            follow_file = false,
            -- Show dotfiles by default.
            hidden = true,
          },
        },
      },
    },
  },
}

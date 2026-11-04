return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>t",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "File Tree (root dir)",
      },
    },
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
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Open Oil" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        -- Keep dotfiles visible, matching the previous explorer behavior.
        show_hidden = true,
      },
    },
  },
}

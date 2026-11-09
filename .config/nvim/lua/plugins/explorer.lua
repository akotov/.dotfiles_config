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
      keymaps = {
        -- Move to the left split instead of opening the selected entry there.
        ["<C-h>"] = {
          callback = function()
            vim.cmd("wincmd h")
          end,
          desc = "Go to Left Window",
          mode = "n",
        },
        -- Keep Ctrl-h/l consistent with split navigation outside Oil.
        ["<C-l>"] = {
          callback = function()
            vim.cmd("wincmd l")
          end,
          desc = "Go to Right Window",
          mode = "n",
        },
        -- Open the entry under the cursor; for directories, enter the folder.
        ["l"] = "actions.select",
      },
      view_options = {
        -- Keep dotfiles visible, matching the previous explorer behavior.
        show_hidden = true,
      },
    },
  },
}

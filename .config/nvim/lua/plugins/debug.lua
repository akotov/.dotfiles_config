-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dappython = require 'dap-python'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'python',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<leader>dd', dap.continue, { desc = 'Debug: Start/Continue Debug' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<leader>dso', dap.step_out, { desc = 'Debug: Step Out/Quit' })

    vim.keymap.set('n', '<leader>dc', dapui.close, { desc = 'Debug: UI: Close' })
    vim.keymap.set('n', '<leader>do', dapui.open, { desc = 'Debug: UI: Open' })

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = 'pause',
          play = 'play',
          step_into = 'into',
          step_over = 'over',
          step_out = 'out',
          step_back = 'back',
          run_last = 'run_last',
          terminate = 'terminate',
          disconnect = 'disconnect',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    -- dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    -- dap.listeners.before.event_exited['dapui_config'] = dapui.close

    --  PYTHON SPECIFIC
    require("dap-python").setup("python")

    -- require('dap-python').test_runners = {}
    local test_runners = require('dap-python').test_runners
    -- `test_runners` is a table. The keys are the runner names like `unittest` or `pytest`.
    -- The value is a function that takes two arguments:
    -- The classnames and a methodname
    -- The function must return a module name and the arguments passed to the module as list.

    ---@param classnames string[]
    ---@param methodname string?
    test_runners.pytest2 = function(classnames, methodname)
      print("inside test_runner.pytest", vim.inspect(classnames), vim.inspect(methodname))

      local path = ""
      if #classnames > 0 then
        path = table.concat({
          table.concat(classnames, ":"),
          methodname,
        }, "::")
      else
        path = methodname
      end

      return 'pytest', { "-s", "-v", "--log-level=20", path }
    end

    print('test_runners:', vim.inspect(test_runners))

    vim.keymap.set('n', '<leader>dtm', dappython.test_method, { desc = 'DAP-Python: Test Method' })
    vim.keymap.set('n', '<leader>dtc', dappython.test_class, { desc = 'DAP-Python: Test Class' })
    -- end of configure
  end,
}

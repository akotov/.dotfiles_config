--
-- Place for remapped shortcuts

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>p", vim.cmd.Ex, { desc = "Project ..." })

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project View" })

-- ?
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<СR>')
-- Map <Esc> to toggle between normal and insert mode
vim.api.nvim_set_keymap('n', '<Esc>', ':startinsert<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Esc>', '<C-o>:stopinsert<CR>', { noremap = true, silent = true })


-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ?
--
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })



local function open_csv_in_csvlens_thru_new_tmux_pane()
  local current_file_path = vim.fn.expand('%:p')
  print("Opening " .. current_file_path .. " in another `tmux pane` using `csvlens`")

  local command = 'tmux split-window -h "csvlens ' .. current_file_path .. '"'
  os.execute(command)
end

local function open_csv_in_csvlens_thru_new_tmux_window()
  local current_file_path = vim.fn.expand('%:p')
  print("Opening " .. current_file_path .. " in another `tmux pane` using `csvlens`")

  -- local command = 'tmux new-window "csvlens ' .. current_file_path .. '"'
  local command = 'tmux new-window "zsh -c \\"csvlens ' .. current_file_path .. '\\""'
  os.execute(command)
end

vim.keymap.set('n', '<leader>csv', open_csv_in_csvlens_thru_new_tmux_pane,
  { desc = 'Open current CSV file using `csvlens`' })
vim.keymap.set('n', '<leader>csw', open_csv_in_csvlens_thru_new_tmux_window,
  { desc = 'Open current CSV file using `csvlens`' })

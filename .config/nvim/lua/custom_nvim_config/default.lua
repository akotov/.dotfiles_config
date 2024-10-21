--
-- Custom settings (properties)
-- Custom behaviour
--

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true

vim.opt.signcolumn = 'yes'


-- ?
-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

--- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto-switch back to Normal mode after inactivity timeout in Insert mode
vim.opt.updatetime = 10000 -- Set updatetime to 10000ms (10 seconds)
vim.cmd [[
  autocmd CursorHoldI * stopinsert
  autocmd CursorHoldI * lua vim.api.nvim_echo({{'Switched to Normal mode due to inactivity in Insert mode', 'Highlight'}}, false, {})
]]


vim.opt.conceallevel = 1

vim.opt.langmap =
'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,Ж:'

-- Autosave Tiemr
-- Function to save the current buffer
local function autosave()
  if vim.bo.modified then
    vim.cmd 'wa'
  end
end

-- Timer handle
local autosave_timer = nil

-- Function to reset the timer
local function reset_autosave_timer()
  if autosave_timer ~= nil then
    vim.fn.timer_stop(autosave_timer)
  end

  -- Set the timer to trigger after 10 seconds (10000 ms)
  autosave_timer = vim.fn.timer_start(10000, autosave)
end

-- Set up autocommands to reset the timer on InsertCharPre and InsertLeave events
vim.api.nvim_create_autocmd({ 'InsertCharPre', 'InsertLeave' }, {
  pattern = '*',
  callback = reset_autosave_timer,
})

-- Initialize the timer when entering insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  callback = reset_autosave_timer,
})

-- cmdheight

vim.o.cmdheight = 2


vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor"
}, ",")


--- Ricing Netrw this mega file tree
-- Set Netrw to open in a vertical split
vim.g.netrw_browse_split = 3

-- Hide banner
vim.g.netrw_banner = 0

-- Set the width of the Netrw window
vim.g.netrw_winsize = 65

-- Enable tree-style listing
vim.g.netrw_liststyle = 3

-- Sort directories first
vim.g.netrw_sort_sequence = '[\\/]*$,*'

-- Disable preview window
vim.g.netrw_preview = 0

-- Set the default directory view to tree view
vim.g.netrw_altv = 1

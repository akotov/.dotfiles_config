return {
  'skywind3000/vim-quickui',
  init = function()
    -- Add some config to run BEFORE plugin/quickui.vim loads
    vim.g.quickui_border_style = 3
    vim.g.quickui_color_scheme = 'papercol-dark'
  end,
  config = function()
    -- Add some config AFTER plugin/quickui.vim has been loaded
    vim.cmd [[ call quickui#menu#reset() ]]

    vim.cmd [[call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])
  ]]

    vim.api.nvim_set_keymap('n', '<leader>m', ':call quickui#menu#open()<CR>', { noremap = true, desc = 'Menu' })
  end,
}

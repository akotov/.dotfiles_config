-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local ollama_lhs = (vim.g.mapleader or "\\") .. "aq"
if vim.fn.maparg(ollama_lhs, "n") == "" then
  vim.keymap.set("n", "<leader>aq", function()
    require("config.ollama").ask()
  end, { desc = "Ask Ollama about current file" })
end

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local ollama_lhs = (vim.g.mapleader or "\\") .. "aq"
if vim.fn.maparg(ollama_lhs, "n") == "" then
  vim.keymap.set("n", "<leader>aq", function()
    require("config.ollama").ask()
  end, { desc = "Ask Ollama about current file" })
end

vim.keymap.set("n", "<leader>cA", function()
  vim.g.cmp_enabled = vim.g.cmp_enabled == false
  if not vim.g.cmp_enabled then
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.hide()
    end
  end
  vim.notify("Autocomplete " .. (vim.g.cmp_enabled and "enabled" or "disabled"))
end, { desc = "Toggle autocomplete" })

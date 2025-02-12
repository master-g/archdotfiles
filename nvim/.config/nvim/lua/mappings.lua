require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>fg", "<cmd> Telescope live_grep <cr>", { desc = "Telescope live grep" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

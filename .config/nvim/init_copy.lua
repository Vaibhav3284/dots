--[[ Basic Editor Settings ]]
vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 2
vim.o.termguicolors = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menu,menuone,noselect"

--[[ Keymaps ]]
local map = vim.keymap.set

-- General & File
map("n", "<leader>s", ":update :source %<CR>", { desc = "Source config" })
map("n", "<leader>w", ":write<CR>", { desc = "Write file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- Clipboard
map("n", "<leader>y", '"+y', { desc = "Yank to system" })
map("n", "<leader>p", '"+p', { desc = "Paste from system" })

-- Window Navigation (Asumiendo que querías usar Ctrl+hjkl)
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- Plugin: Oil & Pick
map("n", "<leader>e", ":Oil<CR>", { desc = "Open Oil" })
map("n", "<leader>f", ":Pick files<CR>", { desc = "Find files" })

-- LSP Keymaps (Globales)
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format code" })

--[[ Plugin Management ]]
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/Saghen/blink.cmp", version = "1.*" },

	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/williamboman/mason.nvim" },
	{ src = "https://github.com/williamboman/mason-lspconfig.nvim" },
})

--[[ Plugin Setup ]]
require("mini.pairs").setup()
require("oil").setup({ columns = { "icon", "permissions", "size" } })
require("mini.pick").setup()

--[[ Theme ]]
vim.opt.background = "dark"
require("vague").setup({ transparent = true })
vim.cmd.colorscheme("vague")

--[[ LSP & Completion (La magia minimalista) ]]

-- 1. Blink (Autocompletado)
local blink = require("blink.cmp")
blink.setup({
	keymap = { preset = "enter" },
	appearance = { nerd_font_variant = "mono" },
	sources = { default = { "lsp", "path", "buffer" } },
})

require("mason").setup({
	ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"gopls",
		"rust_analyzer",
		"lua_ls",
		"ts_ls",
		"html",
		"cssls",
		"jsonls",
	},
	handlers = {
		-- Esto configura automáticamente CADA servidor instalado sin repetir código
		function(server_name)
			require("lspconfig")[server_name].setup({
				capabilities = blink.get_lsp_capabilities(),
			})
		end,
	},
}

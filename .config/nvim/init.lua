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
vim.o.laststatus = 0
vim.opt.foldlevel = 99

vim.opt.fillchars = { eob = " " }

--[[ Keymaps Generales ]]
local map = vim.keymap.set

-- Key for clojure
vim.g.maplocalleader = ","

-- Code move
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Mover línea abajo" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Mover línea arriba" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Mover selección abajo" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Mover selección arriba" })

-- General & File
map("n", "<leader>s", ":update | source %<CR>", { desc = "Source config" })
map("n", "<leader>w", ":write<CR>", { desc = "Write file" })
map("n", "<leader>q", ":quit<CR>", { desc = "Quit" })

-- Window Navigation (Corregidos los keymaps vacíos)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Plugin: Oil & Pick
map("n", "e", ":Oil<CR>", { desc = "Open Oil file explorer" })
map({ "n", "v", "x" }, "<leader>f", ":Pick files<CR>", { desc = "Pick files" })

-- Plugin floating terminal
map("n", "<leader>p", ":ToggleTerm<CR>", { desc = "Open a centered terminal" })

-- Plugin zen mode
map("n", "<leader>z", ":ZenMode<CR>", { desc = "Enter zen mode" })

--[[ Plugin Management ]]
vim.pack.add({

	-- Clojure
	{ src = "https://github.com/Olical/conjure" },

	-- Java
	{ src = 'https://github.com/JavaHello/spring-boot.nvim',      version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0' },
	{ src = 'https://github.com/MunifTanjim/nui.nvim' },
	{ src = 'https://github.com/mfussenegger/nvim-dap' },
	{ src = 'https://github.com/nvim-java/nvim-java' },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },

	-- Colorschemes
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/mellow-theme/mellow.nvim" },
	{ src = "https://github.com/savq/melange-nvim" },
	{ src = "https://github.com/oskarnurm/koda.nvim" },
	{ src = "https://github.com/folke/zen-mode.nvim" },
	{ src = "https://github.com/sainnhe/gruvbox-material" },

	-- More stuff
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/Saghen/blink.cmp",                version = "1.*" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" }
})

--[[ nvim-treesitter Configuration ]]
require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
	"go", "gomod", "rust", "lua", "vim", "vimdoc", "query", "javascript", "html", "css", "clojure", "xml", "jdtls",
	"gradle", "groovy", "java", "typst",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "rust", "lua", "javascript", "html", "css", "clojure", "xml", "jdtls", "java", "java", "typst" },
	callback = function()
		vim.treesitter.start()

		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,

})


--[[ Plugin Configuration ]]

require("toggleterm").setup {
	direction = 'float',
	float_opts = {
		border = 'curved',
	}
}

require("mini.pairs").setup()

require("zen-mode").setup()

require("oil").setup({
	columns = { "icon", "permissions", "size" },
	view_options = {
		show_hidden = true,
	},
})

require("mini.pick").setup({
	options = { content_trim = "auto", use_cache = true },
})


--[[ AUTOCOMPLETE (Blink.cmp) ]]
local blink = require("blink.cmp")
blink.setup({
	keymap = { preset = "enter" },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { "lsp", "path", "buffer" },
	},
	fuzzy = { implementation = "lua" },
})

--[[ LSP Configuration ]]
local capabilities = blink.get_lsp_capabilities()

require('java').setup({
	jdk = { auto_install = false }, -- Use system JDK
	lombok = { enable = false },
	java_test = { enable = false },
	java_debug_adapter = { enable = false },
	spring_boot_tools = { enable = false }
})

local lsps = {
	{ "gopls",             { capabilities = capabilities } },
	{ "rust_analyzer",     { capabilities = capabilities } },
	{ "lua_ls",            { capabilities = capabilities } },
	{ "ts_ls",             { capabilities = capabilities } },
	{ "cssls",             { capabilities = capabilities } },
	{ "html",              { capabilities = capabilities } },
	{ "jsonls",            { capabilities = capabilities } },
	{ "dockerls",          { capabilities = capabilities } },
	{ "yamlls",            { capabilities = capabilities } },
	{ "ada_ls",            { capabilities = capabilities } },
	{ "racket_langserver", { capabilities = capabilities } },
	{ "clojure_lsp",       { capabilities = capabilities } },
	{ "gradle_ls",         { capabilities = capabilities } },
	{ "groovy_ls",         { capabilities = capabilities } },
	{ "typst_lsp",         { capabilities = capabilities } },
}

for _, lsp in ipairs(lsps) do
	local name, config = lsp[1], lsp[2] or {}
	vim.lsp.config[name] = config
	vim.lsp.enable(name)
end

vim.lsp.enable('jdtls')

-- Keymaps LSP
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- Configuración específica para Ada
vim.api.nvim_create_autocmd("FileType", {
	pattern = "ada",
	callback = function()
		vim.keymap.del("i", "aj", { buffer = true })
		vim.keymap.del("i", "al", { buffer = true })
		vim.bo.expandtab = true
		vim.bo.tabstop = 3
		vim.bo.shiftwidth = 3
		vim.bo.textwidth = 79
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = 0,
			callback = function()
				local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				for i, line in ipairs(content) do
					content[i] = line:gsub("\t", "   ")
				end
				vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
			end,
		})
	end,
})


require("koda").setup({})

--[[LIGHT]]
-- vim.opt.background = "light"
-- vim.cmd.colorscheme("koda")

--[DARK]
vim.opt.background = "dark"
-- vim.cmd.colorscheme("mellow")
-- vim.cmd.colorscheme("melange")
--

-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#d4be98" }) -- Usar un color que combine con Gruvbox
-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
-- vim.api.nvim_set_hl(0, "MsgArea", { bg = "none" })


vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_transparent_background = 0
vim.cmd.colorscheme("gruvbox-material")

vim.api.nvim_set_hl(0, "Normal", { bg = "#151515", fg = "#fbf1c7" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#151515", fg = "#fbf1c7" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#151515" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#151515", fg = "#151515" }) -- Ocultar tildes
vim.api.nvim_set_hl(0, "MsgArea", { bg = "#151515" })

-- Ventanas flotantes (LSP, Autocomplete)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#151515" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#151515", fg = "#867970" }) -- Borde sutil color 'negro' desaturado

-- Números de línea (Usamos el color 'negro' desaturado para que no distraigan)
vim.api.nvim_set_hl(0, "LineNr", { bg = "#151515", fg = "#867970" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#151515", fg = "#a3ae6d", bold = true }) -- Verde desaturado al resaltar

-- View errors on cmdline

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = false,
	severity_sort = true,
})

local function diagnostic_sumary()
	local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) -- Only get the errors
	if #diagnostics == 0 then
		return ""
	end

	local lines = {}
	for _, diag in ipairs(diagnostics) do
		lines[diag.lnum + 1] = true
	end

	local line_list = {}
	for line in pairs(lines) do
		table.insert(line_list, line)
	end
	table.sort(line_list)

	local max_lines = 5
	local line_str = table.concat(line_list, ", ")
	if #line_list > max_lines then
		line_str = table.concat({ unpack(line_list, 1, max_lines) }, ", ") .. ", ..."
	end

	return string.format("E:%d (E at: %s)", #diagnostics, line_str)
end

vim.api.nvim_create_autocmd({ 'BufWritePost', "InsertLeave", "DiagnosticChanged" }, {
	callback = function()
		local summary = diagnostic_sumary()
		if summary ~= "" then
			vim.cmd('echo "' .. summary .. '"')
			-- vim.cmd('redraw')
		end
	end,
})

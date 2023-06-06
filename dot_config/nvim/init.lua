vim.opt.guifont = "FiraCode Nerd Font:h13"
vim.g.neovide_transparency = 0.5
-- vim.g.neovide_no_idle = "v:true"

vim.opt.nu = true
vim.opt.wrap = true
vim.opt.lbr = true
vim.opt.tw = 0
vim.opt.virtualedit = "block"
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.indentexpr = ""
vim.opt.confirm = true
vim.opt.spelllang = "en,cjk"
vim.opt.shell = "/bin/sh"
vim.opt.scrolloff = 15

vim.cmd([[
	nnoremap <expr> j v:count ? 'j' : 'gj'
	nnoremap <expr> k v:count ? 'k' : 'gk'
]])
vim.cmd([[
	map Q gq
	noremap Y y$
	nnoremap < <<
	nnoremap > >>
	nnoremap U <C-r>
]])
vim.cmd([[
	noremap <silent> H g^
	noremap <silent> L g$
	noremap <silent> J 5gj
	noremap <silent> K 5gk
]])
vim.cmd([[
	noremap <C-f> <C-w>w
    noremap <C-k> <C-w>k
    noremap <C-j> <C-w>j
    noremap <C-h> <C-w>h
    noremap <C-l> <C-w>l
	noremap s <nop>
	noremap ss :vsplit<CR>
	noremap sd :split<CR>
	noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
	noremap sj :set splitbelow<CR>:split<CR>
	noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
	noremap sl :set splitright<CR>:vsplit<CR>
	noremap so <C-w>o
	noremap su <C-w>t<C-w>K
	noremap sv <C-w>t<C-w>H
]])
vim.cmd([[
	nnoremap <silent> <M-h> :BufferLineCyclePrev<CR>
	nnoremap <silent> <M-l> :BufferLineCycleNext<CR>
    nnoremap <silent> <M-H> :BufferLineMovePrev<CR>
    nnoremap <silent> <M-L> :BufferLineMoveNext<CR>
	nnoremap <silent> <M-p> :b#<CR>
	nnoremap <silent> <M-n> :e
	nnoremap <silent> <M-q> :bd<CR>
	nnoremap <silent> <M-Q> :bd!<CR>
	inoremap <silent> <M-h> <ESC>:BufferLineCyclePrev<CR>
	inoremap <silent> <M-l> <ESC>:BufferLineCycleNext<CR>
	inoremap <silent> <M-p> <ESC>:b#<CR>
	inoremap <silent> <M-n> <ESC>:enew<CR>
	inoremap <silent> <M-q> <ESC>:bd<CR>
	inoremap <silent> <M-Q> <ESC>:bd!<CR>
	noremap <C-n> :vnew<CR>
]])
vim.cmd([[
    nnoremap <M-j> :m .+1<CR>==
    nnoremap <M-k> :m .-2<CR>==
    inoremap <M-j> <ESC>:m .+1<CR>==gi
    inoremap <M-k> <ESC>:m .-2<CR>==gi
    xnoremap <M-j> :m'>+<CR>==gv
    xnoremap <M-k> :m-2<CR>==gv
	nnoremap <M-J> :t .<CR>
	nnoremap <M-K> :t .-1<CR>
	xnoremap <M-J> :t'><CR>gv
	xnoremap <M-K> :t-1<CR>gv
]])

vim.g.mapleader = " "

vim.cmd([[
    noremap <LEADER>rc :e $MYVIMRC<CR>
    nnoremap <LEADER>q :q<CR>
    nnoremap <LEADER>Q :q!<CR>
    nnoremap <LEADER>w :w<CR>
    noremap <LEADER>h :nohls<CR>
    noremap <LEADER>j J
    nnoremap <C-q> :q!<CR>
    inoremap <C-q> <ESC>:q!<CR>
    inoremap <C-s> <ESC>:w<CR>
]])

vim.cmd([[
    noremap s <nop>
    noremap ss :vsplit<CR>
    noremap sd :split<CR>
    noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
    noremap sj :set splitbelow<CR>:split<CR>
    noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
    noremap sl :set splitright<CR>:vsplit<CR>
    noremap so <C-w>o
    " Place the two screens up and down
    noremap su <C-w>t<C-w>K
    " Place the two screens side by side
    noremap sv <C-w>t<C-w>H

    " Resize splits with arrow keys
    noremap <C-up> :res +5<CR>
    noremap <C-down> :res -5<CR>
    noremap <C-left> :vertical resize-5<CR>
    noremap <C-right> :vertical resize+5<CR>

    " ================
    " Buffer Management
    " ================

    nnoremap <M-h> :bp<CR>
    nnoremap <M-l> :bn<CR>
    nnoremap <M-p> :b#<CR>
    nnoremap <M-n> :enew<CR>
    nnoremap <M-q> :bd<CR>
    nnoremap <M-Q> :bd!<CR>
    inoremap <M-h> <ESC>:bp<CR>
    inoremap <M-l> <ESC>:bn<CR>
    inoremap <M-p> <ESC>:b#<CR>
    inoremap <M-n> <ESC>:enew<CR>
    inoremap <M-q> <ESC>:bd<CR>
    inoremap <M-Q> <ESC>:bd!<CR>
    noremap <C-n> :vnew<CR>
]])

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"glacambre/firenvim",

		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
	{ "h-hg/fcitx.nvim" },
})

vim.g.firenvim_config = {
    globalSettings = { cmdlineTimeout = 500 },
    localSettings = {
        [".*"] = {
            -- cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
}

if vim.g.started_by_firenvim == true then
    vim.o.laststatus = 0
end
vim.cmd("colorscheme kanagawa")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
vim.cmd("noremap <LEADER>e :NvimTreeToggle<cr>")
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)")
vim.keymap.set("x", "<leader>/", "<Plug>(comment_toggle_linewise_visual)")

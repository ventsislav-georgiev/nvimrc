-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.o.guifont = 'MesloLGS Nerd Font'
vim.g.undolevels = 1000

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Neovide
if vim.g.neovide then
  -- vim.g.neovide_transparency = 0.9
  vim.g.neovide_show_border = false
  vim.g.neovide_window_blurred = false

  -- Allow usage of option key
  vim.g.neovide_input_macos_option_key_is_meta = 'both'
  vim.g.neovide_hide_mouse_when_typing = true
end

-- [[ Setting options ]]
-- See `:help vim.opt`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Disable undo history (causes issues with undo buffer)
vim.opt.undofile = false

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
vim.opt.scrolloff = 10

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', 'q', '<Nop>')
vim.keymap.set('n', 'Q', '<Nop>')
vim.keymap.set('n', 'QQ', ':q<CR>', { desc = 'Quit' })

-- Disable delete command copying to register
vim.keymap.set({ 'n', 'v' }, 'd', '"_d')
vim.keymap.set({ 'n', 'v' }, 'D', '"_D')
vim.keymap.set({ 'n', 'v' }, 'c', '"_c')
vim.keymap.set({ 'n', 'v' }, 'C', '"_C')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
vim.keymap.set('t', '<C-Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Git Diff View Shortcuts
vim.keymap.set('n', '<leader>df', ':DiffviewFileHistory %<CR>', { desc = '[F]ile History' })
vim.keymap.set('n', '<leader>db', ':DiffviewFileHistory<CR>', { desc = '[B]ranch History' })
vim.keymap.set('n', '<leader>dd', ':DiffviewOpen<CR>', { desc = 'Current [D]iff' })
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = '[C]lose Diff View' })

if vim.g.neovide then
  -- Allow clipboard copy paste in neovim
  vim.keymap.set('n', '<D-a>', 'ggVG') -- Select all
  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set({ 'n', 'v' }, '<D-z>', 'u') -- Undo
  vim.keymap.set({ 'n', 'v' }, '<D-Z>', '<C-r>') -- Redo
  vim.keymap.set('i', '<D-z>', '<ESC>uu') -- Undo
  vim.keymap.set('i', '<D-Z>', '<ESC><C-r>') -- Redo
  vim.keymap.set('n', '<D-c>', 'Vy') -- Copy
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  vim.api.nvim_set_keymap('', '<D-v>', 'p', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

  -- Option arrow keys to move lines and navigation
  vim.keymap.set('n', '<M-up>', ':m -2<CR>')
  vim.keymap.set('n', '<M-down>', ':m +1<CR>')
  vim.keymap.set('n', '<M-left>', 'b')
  vim.keymap.set('n', '<M-right>', 'w')
  vim.keymap.set('i', '<M-left>', '<C-O>b')
  vim.keymap.set('i', '<M-right>', '<C-O>w')
  vim.keymap.set('n', '<D-left>', '0')
  vim.keymap.set('n', '<D-right>', '$')
  vim.keymap.set('i', '<D-left>', '<C-O>0')
  vim.keymap.set('i', '<D-right>', '<C-O>$')
  vim.keymap.set('n', '<D-up>', 'gg')
  vim.keymap.set('n', '<D-down>', 'G')
  vim.keymap.set('n', '<C-->', '<C-O>')
  vim.keymap.set('n', '<C-=>', '<C-I>')

  vim.keymap.set('n', '<D-/>', ':norm gcc<CR>')

  -- Configs
  vim.keymap.set('n', '<D-0>', ':source<CR>')
  vim.keymap.set('n', '<C-0>', ':Lazy<CR>')

  -- Navigate Sessions
  vim.keymap.set('n', '<C-r>', ':SessionManager load_session<CR>')
  vim.keymap.set('n', '<D-R>', ':SessionManager load_current_dir_session<CR>')

  -- Terminal
  vim.keymap.set('t', '<D-k>', 'clear<CR>')
  vim.keymap.set('t', '<M-left>', '<S-left>')
  vim.keymap.set('t', '<M-right>', '<S-right>')
end

-- Allow +- scaling
vim.g.neovide_scale_factor = 0.9

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
end

vim.keymap.set('n', '<D-=>', function()
  change_scale_factor(0.10)
end)

vim.keymap.set('n', '<D-->', function()
  change_scale_factor(-0.10)
end)

-- Spectre
vim.keymap.set('n', '<D-F>', '<cmd>lua require("spectre").toggle()<CR>', { desc = 'Toggle Spectre' })
vim.keymap.set('n', '<D-d>', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = 'Search current word' })
vim.keymap.set('v', '<D-d>', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = 'Search current word' })
vim.keymap.set('n', '<D-f>', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = 'Search on current file' })

--- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Auto-save on changes
vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, { command = 'silent! update' })

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Disable New Line Comment',
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

-- [[ Coc ]]
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = 'yes'

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset('i', '<down>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<down>" : coc#refresh()', opts)
keyset('i', '<up>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<up>"]], opts)

-- Make <Tab> to accept selected completion item or notify coc.nvim to format
keyset('i', '<Tab>', [[coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"]], opts)

-- Use <c-j> to trigger snippets
-- keyset('i', '<c-j>', '<Plug>(coc-snippets-expand-jump)')
-- Use <c-space> to trigger completion
keyset('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })

-- Use `[d` and `]d` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
keyset('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })

-- GoTo code navigation
keyset('n', 'gd', '<Plug>(coc-definition)', { silent = true })
keyset('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
keyset('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
keyset('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Use K to show documentation in preview window
function _G.show_docs()
  local cw = vim.fn.expand '<cword>'
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval 'coc#rpc#ready()' then
    vim.fn.CocActionAsync 'doHover'
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end
keyset('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup('CocGroup', {})
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'CocGroup',
  command = "silent call CocActionAsync('highlight')",
  desc = 'Highlight symbol under cursor on CursorHold',
})

-- Symbol renaming
keyset('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

-- Formatting selected code
-- keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
-- keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd('FileType', {
  group = 'CocGroup',
  pattern = 'typescript,json',
  command = "setl formatexpr=CocAction('formatSelected')",
  desc = 'Setup formatexpr specified filetype(s).',
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd('User', {
  group = 'CocGroup',
  pattern = 'CocJumpPlaceholder',
  command = "call CocActionAsync('showSignatureHelp')",
  desc = 'Update signature help on jump placeholder',
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local coc_opts = { silent = true, nowait = true }
-- keyset('x', '<leader>a', '<Plug>(coc-codeaction-selected)', coc_opts)
-- keyset('n', '<leader>a', '<Plug>(coc-codeaction-selected)', coc_opts)

-- Remap keys for apply code actions at the cursor position.
keyset('n', '<leader>cc', '<Plug>(coc-codeaction-cursor)', coc_opts)
-- Remap keys for apply source code actions for current file.
keyset('n', '<leader>ca', '<Plug>(coc-codeaction-source)', coc_opts)
-- Apply the most preferred quickfix action on the current line.
keyset('n', '<leader>cf', '<Plug>(coc-fix-current)', coc_opts)

-- Remap keys for apply refactor code actions.
-- keyset('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
keyset('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
keyset('n', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

-- Run the Code Lens actions on the current line
keyset('n', '<leader>cl', '<Plug>(coc-codelens-action)', coc_opts)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset('x', 'if', '<Plug>(coc-funcobj-i)', coc_opts)
keyset('o', 'if', '<Plug>(coc-funcobj-i)', coc_opts)
keyset('x', 'af', '<Plug>(coc-funcobj-a)', coc_opts)
keyset('o', 'af', '<Plug>(coc-funcobj-a)', coc_opts)
keyset('x', 'ic', '<Plug>(coc-classobj-i)', coc_opts)
keyset('o', 'ic', '<Plug>(coc-classobj-i)', coc_opts)
keyset('x', 'ac', '<Plug>(coc-classobj-a)', coc_opts)
keyset('o', 'ac', '<Plug>(coc-classobj-a)', coc_opts)

-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
-- local opts = { silent = true, nowait = true, expr = true }
-- keyset('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
-- keyset('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
-- keyset('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
-- keyset('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
-- keyset('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
-- keyset('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
-- keyset('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command('Format', "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend "%{coc#status()}%{get(b:,'coc_current_function','')}"

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keyset('n', '<leader>cd', ':<C-u>CocList diagnostics<cr>', opts)
-- Manage extensions
keyset('n', '<leader>ce', ':<C-u>CocList extensions<cr>', opts)
-- Show commands
keyset('n', '<leader>cm', ':<C-u>CocList commands<cr>', opts)
-- Find symbol of current document
keyset('n', '<leader>co', ':<C-u>CocList outline<cr>', opts)
-- Search workspace symbols
keyset('n', '<leader>cs', ':<C-u>CocList -I symbols<cr>', opts)
-- Do default action for next item
keyset('n', ']d', ':<C-u>CocNext<cr>', opts)
-- Do default action for previous item
keyset('n', '[d', ':<C-u>CocPrev<cr>', opts)
-- Resume latest coc list
keyset('n', '<leader>cp', ':<C-u>CocListResume<cr>', opts)

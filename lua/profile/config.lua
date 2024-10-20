-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.o.guifont = 'MesloLGS Nerd Font:h12'
vim.g.undolevels = 1000

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Whitespace
vim.o.tabstop = 4 -- Tab character looks like 4 spaces
vim.o.expandtab = false -- Pressing the Tab key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.list = true

local space = '·'
vim.opt.listchars:append {
  tab = '» ',
  multispace = space,
  lead = space,
  trail = space,
  nbsp = space,
}

-- vim.cmd [[match TrailingWhitespace /\s\+$/]]

-- vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
-- vim.api.nvim_create_autocmd('InsertEnter', {
--   callback = function()
--     vim.opt.listchars.trail = nil
--     vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Whitespace' })
--   end,
-- })

-- vim.api.nvim_create_autocmd('InsertLeave', {
--   callback = function()
--     vim.opt.listchars.trail = space
--     vim.api.nvim_set_hl(0, 'TrailingWhitespace', { link = 'Error' })
--   end,
-- })

-- Neovide
if vim.g.neovide then
  -- vim.g.neovide_transparency = 0.9
  vim.g.neovide_show_border = false
  vim.g.neovide_window_blurred = false

  -- Allow usage of option key
  vim.g.neovide_input_macos_option_key_is_meta = 'both'
  vim.g.neovide_hide_mouse_when_typing = true

  -- Allow +- scaling
  vim.g.neovide_scale_factor = 1.0

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
  end

  vim.keymap.set('n', '<D-=>', function()
    change_scale_factor(0.10)
  end)

  vim.keymap.set('n', '<D-->', function()
    change_scale_factor(-0.10)
  end)
end

-- Auto write/load file from disk when changed
vim.opt.autoread = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = false

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
vim.opt.undofile = true

-- Allow backspacing over everything in insert mode
vim.opt.backspace = 'indent,eol,start'

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

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

--- [[ Langmaper ]]
local function escape(str)
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

local en = [[§qwertyuiop[]asdfghjkl;'\`zxcvbnm,./]]
local bg = [[§явертъуиопшщасдфгхйкл;'ючзьцжбнм,./]]
local en_shift = [[±QWERTYUIOP{}ASDFGHJKL:"|~ZXCVBNM<>?]]
local bg_shift = [[±ЯВЕРТЪУИОПШЩАСДФГХЙКЛ:"ЮЧЗѝЦЖБНМ<>?]]

vim.opt.langmap = vim.fn.join({
  -- | `to` should be first     | `from` should be second
  escape(bg_shift)
    .. ';'
    .. escape(en_shift),
  escape(bg) .. ';' .. escape(en),
}, ',')

--- [[ Keymaps ]]
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', 'QQ', ':q<CR>', { desc = 'Quit' })

-- Help
vim.keymap.set('n', '<D-F1>', ':NoiceAll<CR>', { desc = 'Open [N]oice' })

-- Disable delete command copying to register
vim.keymap.set({ 'n', 'v' }, 'd', '"_d')
vim.keymap.set({ 'n', 'v' }, 'D', '"_D')
vim.keymap.set({ 'n', 'v' }, 'c', '"_c')
vim.keymap.set({ 'n', 'v' }, 'C', '"_C')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

-- Git Diff View Shortcuts
vim.keymap.set('n', '<leader>gf', [[<cmd>lua require('diffview').file_history(nil, '%')<CR>]], { desc = '[F]ile History' })
vim.keymap.set('n', '<leader>gb', [[<cmd>lua require('diffview').file_history()<CR>]], { desc = '[B]ranch History' })
vim.keymap.set('n', '<leader>gc', [[<cmd>lua require('diffview').open()<CR>]], { desc = 'Current [D]iff' })
vim.keymap.set('n', '<D-S>', [[<cmd>lua require('diffview').open()<CR>]], { desc = 'Current [D]iff' })
vim.keymap.set('n', '<leader>gq', [[<cmd>lua require('diffview').close()<CR>]], { desc = '[C]lose Diff View' })

-- General Operations
vim.keymap.set('n', '<D-a>', 'ggVG') -- Select all
vim.keymap.set('n', '<D-s>', ':update<CR>') -- Save
vim.keymap.set({ 'n', 'v' }, '<D-z>', 'u') -- Undo
vim.keymap.set({ 'n', 'v' }, '<D-Z>', '<C-r>') -- Redo
vim.keymap.set('i', '<D-z>', '<ESC>u') -- Undo
vim.keymap.set('i', '<D-Z>', '<ESC><C-r>') -- Redo
vim.keymap.set('n', '<D-c>', 'Vy') -- Copy
vim.keymap.set('v', '<D-c>', '"+y') -- Copy
vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
vim.keymap.set('n', '<D-x>', 'Vx') -- Cut line normal mode
vim.keymap.set('v', '<D-x>', 'x') -- Cut visual mode
vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set('n', '<backspace>', '"_X') -- Delete char
vim.keymap.set('n', '<del>', '"_x') -- Delete char
vim.keymap.set('v', '<backspace>', '"_d') -- Delete selection
vim.keymap.set('v', '<del>', '"_d') -- Delete selection
vim.keymap.set('n', '<D-P>', '<C-^>') -- Switch between last two buffers
vim.keymap.set('n', '<D-w>', ':bd!<CR>') -- Close buffer
vim.keymap.set('v', '<Tab>', '>gv') -- Indent
vim.keymap.set('v', '<S-Tab>', '<gv') -- Unindent
vim.keymap.set('n', '<D-n>', ':enew<CR>') -- New buffer

vim.api.nvim_set_keymap('', '<D-v>', 'p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })

-- Remap up and down arrow keys for command-line autocomplete navigation
vim.api.nvim_set_keymap('c', '<Down>', '<C-n>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('c', '<Up>', '<C-p>', { noremap = true, silent = true })

-- Option arrow keys to move lines and navigation
-- = to reindent, . current line number, '< begging of selection, '> end of selection, gv reselect last selection
vim.keymap.set('n', '<M-up>', ':m .-2<CR>==')
vim.keymap.set('n', '<M-down>', ':m .+1<CR>==')
vim.keymap.set('v', '<M-up>', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', '<M-down>', ":m '>+1<CR>gv=gv")
vim.keymap.set('i', '<M-up>', '<Esc>:m .-2<CR>==gi')
vim.keymap.set('i', '<M-down>', '<Esc>:m .+1<CR>==gi')
vim.keymap.set({ 'n', 'v' }, '<M-left>', 'b')
vim.keymap.set({ 'n', 'v' }, '<M-right>', 'w')
vim.keymap.set('i', '<M-left>', '<C-O>b')
vim.keymap.set('i', '<M-right>', '<C-O>w')
vim.keymap.set({ 'n', 'v' }, '<D-left>', '0')
vim.keymap.set({ 'n', 'v' }, '<D-right>', '$')
vim.keymap.set('i', '<D-left>', '<C-O>0')
vim.keymap.set('i', '<D-right>', '<C-O>$')
vim.keymap.set({ 'n', 'v' }, '<D-up>', 'gg')
vim.keymap.set({ 'n', 'v' }, '<D-down>', 'G')
vim.keymap.set('n', '<home>', 'gg')
vim.keymap.set('n', '<end>', 'G')
vim.keymap.set('n', '<C-->', '<C-O>')
vim.keymap.set('n', '<C-=>', '<C-I>')
vim.keymap.set({ 'n', 'v' }, '<S-up>', '10k')
vim.keymap.set({ 'n', 'v' }, '<S-down>', '10j')

-- Navigate between open buffers
vim.keymap.set({ 'n', 'v' }, '<C-S-right>', [[<cmd>lua vim.cmd 'bnext'<CR>]])
vim.keymap.set({ 'n', 'v' }, '<C-S-left>', [[<cmd>lua vim.cmd 'bprevious'<CR>]])

-- Commenting
vim.keymap.set('n', '<D-/>', ':norm gcc<CR>')
vim.keymap.set('v', '<D-/>', ':Commentary<CR>')

-- Configs
vim.keymap.set('n', '<D-0>', ':source<CR>')
vim.keymap.set('n', '<C-0>', ':Lazy<CR>')
vim.keymap.set('n', '<M-0>', [[<cmd>lua require("mason.ui").open()<CR>]])

-- Navigate Sessions
vim.keymap.set('n', '<C-r>', ':SessionManager load_session<CR>')
vim.keymap.set('n', '<D-R>', ':SessionManager load_current_dir_session<CR>')

-- Terminal
vim.keymap.set({ 'n', 'v' }, '<D-§>', [[<cmd>lua require('toggleterm').toggle_command()<CR>]], { silent = true }) -- Toggle terminal
vim.keymap.set('t', 'QQ', '<C-\\><C-n>:q<cr>', { silent = true }) -- Close terminal
vim.keymap.set('t', '<D-x>', '<C-\\><C-n>', { silent = true }) -- Exit terminal mode
vim.keymap.set('t', '<D-k>', '<C-l>', { silent = true }) -- Clear terminal
vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+Pi') -- Paste terminal mode
vim.keymap.set('n', '<D-l>', '<C-\\><C-n><C-w>j', { silent = true }) -- Move to terminal
vim.keymap.set('t', '<D-l>', '<C-\\><C-n><C-w>k', { silent = true }) -- Move to editor
vim.keymap.set('t', '<C-up>', '<C-\\><C-n><C-w>k', { silent = true }) -- Move to editor
vim.keymap.set('t', '<M-left>', '<esc>b', { silent = true }) -- Jump back a word
vim.keymap.set('t', '<M-right>', '<esc>f', { silent = true }) -- Jump forward a word
vim.keymap.set('t', '<D-left>', '<C-a><C-a>', { silent = true }) -- Jump to beginning of line
vim.keymap.set('t', '<D-right>', '<C-e>', { silent = true }) -- Jump to end of line
vim.keymap.set('t', '<D-backspace>', '<C-u>', { silent = true }) -- Delete line
vim.keymap.set('t', '<M-backspace>', '<C-w>', { silent = true }) -- Delete word
vim.keymap.set('t', '<D-z>', '<C-\\><C-_>', { silent = true }) -- Undo last edit
vim.keymap.set('t', '<D-S>', '<C-\\><C-n><C-w>k<cmd><cmd>lua require("diffview").open()<CR>', { silent = true }) -- Open diff view
vim.keymap.set('t', '<D-E>', '<C-\\><C-n><C-w>k<cmd>Neotree reveal<CR>', { silent = true }) -- Open file tree
vim.keymap.set('t', '<C-r>', '<cmd>SessionManager load_session<CR>', { silent = true }) -- Load session

-- Debugging
vim.keymap.set('n', '<D-1>', [[<cmd>lua require('dap').continue()<CR>]], { desc = 'Start/Continue' })
vim.keymap.set('n', '<D-b>', [[<cmd>lua require('dap').toggle_breakpoint()<CR>]], { desc = 'Toggle [B]reakpoint' })
vim.keymap.set('n', '<leader>dt', [[<cmd>lua require('dap') require('dapui').toggle()<CR>]], { desc = '[T]oggle UI' })

-- Toggle resize terminal
local size = 20
local expanded_size = 60
vim.keymap.set('t', '<C-~>', function()
  local term = require('toggleterm.terminal').get_or_create_term(1)
  size = size == expanded_size and 20 or expanded_size
  term:resize(size)
end, { silent = true })

-- Spectre
vim.keymap.set('n', '<D-F>', '<esc><cmd>lua require("spectre").toggle() require("spectre.actions").clear_file_highlight()<CR>', { desc = 'Toggle Spectre' })
vim.keymap.set('i', '<D-F>', '<esc><cmd>lua require("spectre").toggle() require("spectre.actions").clear_file_highlight()<CR>', { desc = 'Toggle Spectre' })
vim.keymap.set(
  'n',
  '<D-f>',
  '<cmd>lua require("spectre").open_file_search({select_word=true}) require("spectre.actions").clear_file_highlight()<CR>',
  { desc = 'Search on current file' }
)
vim.keymap.set(
  'v',
  '<D-f>',
  '<esc><cmd>lua require("spectre").open_file_search() require("spectre.actions").clear_file_highlight()<CR>',
  { desc = 'Search on current file' }
)

-- Arrow Jumps
vim.keymap.set('n', ';', [[<cmd>lua require('arrow.ui').openMenu()<CR>]])
vim.keymap.set('n', "'", [[<cmd>lua require('arrow.buffer_ui').openMenu()<CR>]])

--- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`
local autocmd_group = vim.api.nvim_create_augroup('AutoCmdGroup', {})

local function close_and_reopen_last_buffer()
  local cursor_pos = vim.fn.getpos '.'

  vim.cmd 'bd'

  if vim.fn.bufnr '#' == -1 then
    return
  end

  vim.cmd 'e#'

  vim.fn.setpos('.', cursor_pos)
end

local function close_all_but_last_n_buffers(n)
  -- Get a list of all listed buffers
  local buffers = vim.tbl_filter(function(buf)
    return vim.fn.buflisted(buf) == 1
  end, vim.api.nvim_list_bufs())

  -- If there are n or fewer buffers, no need to close anything
  if #buffers <= n then
    return
  end

  -- Close all but the last two buffers
  for i = 1, #buffers - n do
    vim.cmd('bd ' .. buffers[i])
  end
end

-- Refresh treesitter highlights after a session is loaded
local is_start = true
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionLoadPost',
  group = autocmd_group,
  callback = function()
    if is_start then
      is_start = false
      return
    end

    if require('lazy').is_loaded 'arrow.nvim' then
      require('arrow.persist').load_cache_file()
    end

    vim.defer_fn(function()
      close_and_reopen_last_buffer()
    end, 100)
  end,
})

-- Reduce open buffers before saving a session
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionSavePre',
  group = autocmd_group,
  callback = function()
    close_all_but_last_n_buffers(6)
  end,
})

-- Close buffers before next session is loaded
vim.api.nvim_create_autocmd({ 'User' }, {
  pattern = 'SessionSavePost',
  group = autocmd_group,
  callback = function()
    close_all_but_last_n_buffers(0)
  end,
})

-- Auto-save on changes
vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  group = autocmd_group,
  callback = function()
    pcall(function()
      vim.cmd 'silent! update | undojoin'
    end)
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = autocmd_group,
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    --  See `:help vim.highlight.on_yank()`
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = autocmd_group,
  desc = 'Disable New Line Comment',
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

-- [[ Terminal ]]
-- Ensure terminal is in insert mode when re-entered
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*toggleterm#*',
  callback = function()
    vim.defer_fn(function()
      vim.cmd 'startinsert'
    end, 0)
  end,
})

-- Set keybindings for terminal
vim.api.nvim_create_autocmd('FileType', {
  group = autocmd_group,
  pattern = '*toggleterm*',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<D-x>', '<cmd>startinsert<CR>', { noremap = true, silent = true })
  end,
})

-- [[ Coc ]]
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Setup lua nvim
vim.api.nvim_create_autocmd('FileType', {
  group = autocmd_group,
  pattern = 'lua',
  callback = function()
    if require('lazy').is_loaded 'coc.nvim' then
      vim.api.nvim_command 'silent call coc#config("Lua.workspace.library", nvim_get_runtime_file("", 1))'
    end
  end,
})

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = 'yes'

local keyset = vim.keymap.set
-- Autocomplete
-- Use Tab for trigger completion with characters ahead and navigate
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset('i', '<down>', [[coc#pum#visible() ? coc#pum#next(1) : "\<down>"]], opts)
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
  desc = 'Highlight symbol under cursor on CursorHold',
  callback = function()
    if require('lazy').is_loaded 'coc.nvim' then
      vim.api.nvim_command 'silent call CocActionAsync("highlight")'
    end
  end,
})

-- Symbol renaming
keyset('n', '<leader>cr', '<Plug>(coc-rename)', { silent = true })

-- Formatting selected code
-- keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
-- keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})

-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd('FileType', {
  group = 'CocGroup',
  pattern = 'typescript,json',
  desc = 'Setup formatexpr specified filetype(s).',
  callback = function()
    if require('lazy').is_loaded 'coc.nvim' then
      vim.opt_local.formatexpr = 'CocAction("formatSelected")'
    end
  end,
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd('User', {
  group = 'CocGroup',
  pattern = 'CocJumpPlaceholder',
  desc = 'Update signature help on jump placeholder',
  callback = function()
    if require('lazy').is_loaded 'coc.nvim' then
      vim.api.nvim_command 'silent call CocActionAsync("showSignatureHelp")'
    end
  end,
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

-- treesj join/split block
vim.keymap.set('n', '<leader>ct', function()
  require('treesj').toggle()
end, { desc = 'Join/Split block' })

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

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keyset('n', '<leader>cd', ':<C-u>CocList diagnostics<cr>', opts)
-- Manage extensions
keyset('n', '<leader>ce', ':<C-u>CocList extensions<cr>', opts)
-- Update extensions
keyset('n', '<leader>cu', ':<C-u>CocUpdate<cr>', opts)
-- Show commands
keyset('n', '<leader>cm', ':<C-u>CocList commands<cr>', opts)
-- Find symbol of current document
keyset('n', '<leader>co', ':<C-u>CocList outline<cr>', opts)
-- Search workspace symbols
keyset('n', '<leader>cs', ':<C-u>CocList -I symbols<cr>', opts)
-- Do default action for next item
-- keyset('n', ']d', ':<C-u>CocNext<cr>', opts)
-- Do default action for previous item
-- keyset('n', '[d', ':<C-u>CocPrev<cr>', opts)
-- Resume latest coc list
keyset('n', '<leader>cp', ':<C-u>CocListResume<cr>', opts)

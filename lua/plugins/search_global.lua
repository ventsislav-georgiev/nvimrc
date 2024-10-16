return {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- ref: https://github.com/TioeAre/nvim/blob/15ca64d647fdb936c4021776b949f0a284126272/lua/plugin_config/user_spectre.lua

    local api = vim.api
    local config = require 'spectre.config'
    local state = require 'spectre.state'
    local utils = require 'spectre.utils'
    local ui = require 'spectre.ui'
    local async = require 'plenary.async'
    local scheduler = async.util.scheduler

    local open_file = function(filename, lnum, col, winid)
      local current_win = api.nvim_get_current_win()
      if winid ~= nil then
        vim.fn.win_gotoid(winid)
      end
      vim.api.nvim_command [[execute "normal! m` "]]
      vim.cmd('e ' .. vim.fn.fnameescape(filename))
      api.nvim_win_set_cursor(0, { lnum, col })
      api.nvim_set_current_win(current_win)
    end
    local preview = function()
      local t = require('spectre.actions').get_current_entry()
      if t == nil then
        return nil
      end
      if config.is_open_target_win and state.target_winid ~= nil then
        open_file(t.filename, t.lnum, t.col, state.target_winid)
      else
        open_file(t.filename, t.lnum, t.col)
      end

      ui.render_file(state.total_item[t.c_line], true)
    end
    require('spectre.actions').preview = preview

    local edit_file = function(filename, lnum, col, winid)
      if winid ~= nil then
        vim.fn.win_gotoid(winid)
      end
      vim.api.nvim_command [[execute "normal! m` "]]
      local escaped_filename = vim.fn.fnameescape(filename)
      vim.cmd('e ' .. escaped_filename)
      api.nvim_win_set_cursor(0, { lnum, col })
    end
    local select_entry = function()
      local t = require('spectre.actions').get_current_entry()
      if t == nil then
        return nil
      end
      if config.is_open_target_win and state.target_winid ~= nil then
        edit_file(t.filename, t.lnum, t.col, state.target_winid)
      else
        edit_file(t.filename, t.lnum, t.col)
      end

      ui.render_file(state.total_item[t.c_line], true)
    end
    require('spectre.actions').select_entry = select_entry

    local function clear_file_highlight()
      local all_bufs = vim.api.nvim_list_bufs()
      for _, buf_id in ipairs(all_bufs) do
        if buf_id ~= state.bufnr and vim.api.nvim_buf_is_loaded(buf_id) then
          vim.api.nvim_buf_clear_namespace(buf_id, config.namespace, 0, -1)
        end
      end
    end
    require('spectre.actions').clear_file_highlight = clear_file_highlight

    local render_line = function(bufnr, namespace, text_opts, view_opts, regex)
      local cfg = state.user_config
      local diff = utils.get_hl_line_text({
        search_query = text_opts.search_query,
        replace_query = text_opts.replace_query,
        search_text = text_opts.search_text,
        show_search = view_opts.show_search,
        show_replace = view_opts.show_replace,
      }, regex)
      local end_lnum = text_opts.is_replace == true and text_opts.lnum + 1 or text_opts.lnum
      local item_line_len = 0
      if cfg.lnum_for_results == true then
        item_line_len = string.len(text_opts.item_line) + 1
        api.nvim_buf_set_lines(bufnr, text_opts.lnum, end_lnum, false, { view_opts.padding_text .. text_opts.item_line .. ' ' .. diff.text })
      else
        api.nvim_buf_set_lines(bufnr, text_opts.lnum, end_lnum, false, { view_opts.padding_text .. diff.text })
      end
      if not view_opts.is_disable then
        for _, value in pairs(diff.search) do
          api.nvim_buf_add_highlight(
            bufnr,
            namespace,
            text_opts.item_search_highlight,
            text_opts.lnum,
            value[1] + view_opts.padding + item_line_len,
            value[2] + view_opts.padding + item_line_len
          )
          -- render in files
          local file_bufnr = vim.fn.bufadd(text_opts.item_filename)
          if vim.api.nvim_buf_is_loaded(file_bufnr) then
            local match_length = value[2] - value[1]
            local item_end_col = text_opts.item_col + match_length
            api.nvim_buf_add_highlight(
              file_bufnr,
              namespace,
              text_opts.item_search_highlight,
              text_opts.item_line - 1,
              text_opts.item_col - 1,
              item_end_col - 1
            )
          end
        end
        for _, value in pairs(diff.replace) do
          api.nvim_buf_add_highlight(
            bufnr,
            namespace,
            cfg.highlight.replace,
            text_opts.lnum,
            value[1] + view_opts.padding + item_line_len,
            value[2] + view_opts.padding + item_line_len
          )
        end
        api.nvim_buf_add_highlight(state.bufnr, config.namespace, cfg.highlight.border, text_opts.lnum, 0, view_opts.padding)
      else
        api.nvim_buf_add_highlight(state.bufnr, config.namespace, cfg.highlight.border, text_opts.lnum, 0, -1)
      end
    end

    -- if highlight_current, spectre and file all need to be re-rendered, else only autocmd needs to render new loaded file
    local render_file = function(current_item, if_highlight_current)
      if not current_item.is_disable then
        local padding = #state.user_config.result_padding
        local item_line_len = 0
        if config.lnum_for_results == true then
          item_line_len = string.len(current_item.lnum) + 1
        end

        local file_bufnr = vim.fn.bufadd(current_item.filename)
        local diff = utils.get_hl_line_text({
          search_query = state.query.search_query,
          replace_query = state.query.replace_query,
          search_text = current_item.search_text,
          show_search = state.view.show_search,
          show_replace = state.view.show_replace,
        }, state.regex)

        if if_highlight_current then
          -- change current item's highlight to SpectreCurrent
          state.total_item[current_item.c_line].search_highlight = state.user_config.highlight.current

          -- clear current item SpectreSearch highlight and re-render spectre
          for _, value in pairs(diff.search) do
            if vim.api.nvim_buf_is_loaded(file_bufnr) then
              vim.api.nvim_buf_clear_namespace(file_bufnr, config.namespace, current_item.lnum - 1, current_item.lnum)
            end
            vim.api.nvim_buf_clear_namespace(state.bufnr, config.namespace, current_item.display_lnum, current_item.display_lnum + 1)
            vim.api.nvim_buf_add_highlight(
              state.bufnr,
              config.namespace,
              state.total_item[current_item.c_line].search_highlight,
              current_item.display_lnum,
              value[1] + padding + item_line_len,
              value[2] + padding + item_line_len
            )
          end
          for _, value in pairs(diff.replace) do
            vim.api.nvim_buf_add_highlight(
              state.bufnr,
              config.namespace,
              config.highlight.replace,
              current_item.display_lnum,
              value[1] + padding + item_line_len,
              value[2] + padding + item_line_len
            )
          end

          -- last item re-render to SpectreSearch highlight
          if state.last_select_item and state.total_item[state.last_select_item.c_line] and current_item.c_line ~= state.last_select_item.c_line then
            -- change last item's highlight
            state.total_item[state.last_select_item.c_line].search_highlight = state.user_config.highlight.search

            local last_item = state.total_item[state.last_select_item.c_line]
            local last_file_bufnr = vim.fn.bufadd(last_item.filename)
            local last_diff = utils.get_hl_line_text({
              search_query = state.query.search_query,
              replace_query = state.query.replace_query,
              search_text = last_item.search_text,
              show_search = state.view.show_search,
              show_replace = state.view.show_replace,
            }, state.regex)
            for _, value in pairs(last_diff.search) do
              local match_length = value[2] - value[1]
              local item_end_col = last_item.col + match_length
              -- last file re-render to SpectreSearch
              if vim.api.nvim_buf_is_loaded(last_file_bufnr) then
                vim.api.nvim_buf_clear_namespace(last_file_bufnr, config.namespace, last_item.lnum - 1, last_item.lnum)
                vim.api.nvim_buf_add_highlight(
                  last_file_bufnr,
                  config.namespace,
                  last_item.search_highlight,
                  last_item.lnum - 1,
                  last_item.col - 1,
                  item_end_col - 1
                )
              end
              -- last item re-render spectre buffer
              vim.api.nvim_buf_clear_namespace(state.bufnr, config.namespace, last_item.display_lnum, last_item.display_lnum + 1)
              vim.api.nvim_buf_add_highlight(
                state.bufnr,
                config.namespace,
                last_item.search_highlight,
                last_item.display_lnum,
                value[1] + padding + item_line_len,
                value[2] + padding + item_line_len
              )
            end
            for _, value in pairs(last_diff.replace) do
              vim.api.nvim_buf_add_highlight(
                state.bufnr,
                config.namespace,
                config.highlight.replace,
                last_item.display_lnum,
                value[1] + padding + item_line_len,
                value[2] + padding + item_line_len
              )
            end
          end
          -- switch last item
          state.last_select_item = state.total_item[current_item.c_line]
        end

        -- render current item in (new loaded) files
        for _, value in pairs(diff.search) do
          local match_length = value[2] - value[1]
          local item_end_col = current_item.col + match_length
          if vim.api.nvim_buf_is_loaded(file_bufnr) then
            vim.api.nvim_buf_add_highlight(
              file_bufnr,
              config.namespace,
              state.total_item[current_item.c_line].search_highlight,
              current_item.lnum - 1,
              current_item.col - 1,
              item_end_col - 1
            )
          end
        end
      end
    end
    require('spectre.ui').render_line = render_line
    require('spectre.ui').render_file = render_file

    local function hl_match(opts)
      if #opts.search_query > 0 then
        api.nvim_buf_add_highlight(state.bufnr, config.namespace, state.user_config.highlight.search, 2, 0, -1)
      end
      if #opts.replace_query > 0 then
        api.nvim_buf_add_highlight(state.bufnr, config.namespace, state.user_config.highlight.replace, 4, 0, -1)
      end
    end

    local do_replace_text = function(opts, async_id)
      state.query = opts or state.query
      hl_match(state.query)
      local count = 1
      for _, item in pairs(state.total_item) do
        if state.async_id ~= async_id then
          return
        end
        ui.render_line(state.bufnr, config.namespace, {
          search_query = state.query.search_query,
          replace_query = state.query.replace_query,
          search_text = item.search_text,
          lnum = item.display_lnum,
          item_line = item.lnum,
          item_col = item.col,
          item_filename = item.filename,
          item_search_highlight = item.search_highlight,
          is_replace = true,
        }, {
          is_disable = item.disable,
          padding_text = state.user_config.result_padding,
          padding = #state.user_config.result_padding,
          show_search = state.view.show_search,
          show_replace = state.view.show_replace,
        }, state.regex)
        count = count + 1
        -- delay to next scheduler after 100 time
        if count > 100 then
          scheduler()
          count = 0
        end
      end
    end
    local function can_edit_line()
      local line = vim.fn.getpos '.'
      if line[2] > config.lnum_UI then
        return false
      end
      return true
    end
    local toggle_line = function(line_visual)
      if can_edit_line() then
        -- delete line content
        vim.cmd [[:normal! ^d$]]
        return false
      end
      local lnum = line_visual or unpack(vim.api.nvim_win_get_cursor(0))
      local item = state.total_item[lnum]
      if item ~= nil and item.display_lnum == lnum - 1 then
        item.disable = not item.disable
        ui.render_line(state.bufnr, config.namespace, {
          search_query = state.query.search_query,
          replace_query = state.query.replace_query,
          search_text = item.search_text,
          lnum = item.display_lnum,
          item_line = item.lnum,
          item_col = item.col,
          item_filename = item.filename,
          item_search_highlight = item.search_highlight,
          is_replace = true,
        }, {
          is_disable = item.disable,
          padding_text = state.user_config.result_padding,
          padding = #state.user_config.result_padding,
          show_search = state.view.show_search,
          show_replace = state.view.show_replace,
        }, state.regex)

        return
      elseif not line_visual then
        -- delete all item in 1 file
        local line = vim.fn.getline(lnum)
        local check = string.find(line, '([^%s]*%:%d*:%d*:)$')
        if check then
          check = state.total_item[lnum + 1]
          if check == nil then
            return
          end
          local disable = not check.disable
          item = check
          local index = lnum + 1
          while item ~= nil and check.filename == item.filename do
            item.disable = disable
            ui.render_line(state.bufnr, config.namespace, {
              search_query = state.query.search_query,
              replace_query = state.query.replace_query,
              search_text = item.search_text,
              lnum = item.display_lnum,
              item_line = item.lnum,
              item_col = item.col,
              item_filename = item.filename,
              item_search_highlight = item.search_highlight,
              is_replace = true,
            }, {
              is_disable = item.disable,
              padding_text = state.user_config.result_padding,
              padding = #state.user_config.result_padding,
              show_search = state.view.show_search,
              show_replace = state.view.show_replace,
            }, state.regex)
            index = index + 1
            item = state.total_item[index]
          end
        end
      end
    end
    local search_handler = function()
      local c_line = 0
      local total = 0
      local start_time = 0
      local padding = #state.user_config.result_padding
      local cfg = state.user_config or {}
      local last_filename = ''
      return {
        on_start = function()
          state.total_item = {}
          state.is_running = true
          state.status_line = 'Start search'
          c_line = config.line_result
          total = 0
          start_time = vim.loop.hrtime()
        end,
        on_result = function(item)
          if not state.is_running then
            return
          end
          item.replace_text = ''
          if string.match(item.filename, '^%.%/') then
            item.filename = item.filename:sub(3, #item.filename)
          end
          item.search_text = utils.truncate(utils.trim(item.text), 255)
          if #state.query.replace_query > 1 then
            item.replace_text = state.regex.replace_all(state.query.search_query, state.query.replace_query, item.search_text)
          end
          if last_filename ~= item.filename then
            ui.render_filename(state.bufnr, config.namespace, c_line, item)
            c_line = c_line + 1
            last_filename = item.filename
          end

          item.display_lnum = c_line
          item.search_highlight = state.user_config.highlight.search
          ui.render_line(state.bufnr, config.namespace, {
            search_query = state.query.search_query,
            replace_query = state.query.replace_query,
            search_text = item.search_text,
            lnum = item.display_lnum,
            item_line = item.lnum,
            item_col = item.col,
            item_filename = item.filename,
            item_search_highlight = item.search_highlight,
            is_replace = false,
          }, {
            is_disable = item.disable,
            padding_text = cfg.result_padding,
            padding = padding,
            show_search = state.view.show_search,
            show_replace = state.view.show_replace,
          }, state.regex)
          c_line = c_line + 1
          total = total + 1
          state.status_line = 'Item  ' .. total
          item.c_line = c_line
          state.total_item[c_line] = item
        end,
        on_error = function(error_msg)
          api.nvim_buf_set_lines(state.bufnr, c_line, c_line + 1, false, { cfg.result_padding .. error_msg })
          api.nvim_buf_add_highlight(state.bufnr, config.namespace, cfg.highlight.border, c_line, 0, padding)
          c_line = c_line + 1
          state.finder_instance = nil
        end,
        on_finish = function()
          if not state.is_running then
            return
          end
          local end_time = (vim.loop.hrtime() - start_time) / 1E9
          state.status_line = string.format('Total: %s match, time: %ss', total, end_time)

          api.nvim_buf_set_lines(state.bufnr, c_line, c_line, false, { cfg.line_sep })
          api.nvim_buf_add_highlight(state.bufnr, config.namespace, cfg.highlight.border, c_line, 0, -1)

          state.vt.status_id = utils.write_virtual_text(state.bufnr, config.namespace_status, config.line_result - 2, { { state.status_line, 'Question' } })
          state.finder_instance = nil
          state.is_running = false
        end,
      }
    end
    require('spectre').do_replace_text = do_replace_text
    require('spectre').toggle_line = toggle_line
    require('spectre').search_handler = search_handler

    require('spectre').setup {
      is_block_ui_break = true,
      live_update = true,
      is_insert_mode = true,
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = {
            '-i',
            '',
            '-E',
          },
        },
      },
      highlight = {
        ui = 'String',
        search = 'SpectreSearch',
        replace = 'SpectreReplace',
        current = 'SpectreCurrent',
      },
      mapping = {
        ['enter_file'] = {
          map = 'o',
          cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
          desc = 'open file',
        },
        ['preview'] = {
          map = '<cr>',
          cmd = "<cmd>lua require('spectre.actions').preview()<CR>",
          desc = 'preview',
        },
        ['close'] = {
          map = 'q',
          cmd = "<cmd>lua require('spectre').close()<CR>",
          desc = 'close',
        },
      },
    }

    -- local c = require('vscode.colors').get_colors()
    vim.api.nvim_set_hl(0, 'SpectreSearch', {
      fg = '#FFCC55',
      bg = '#774836',
    })
    -- vim.api.nvim_set_hl(0, 'SpectreReplace', {
    --   fg = '#000000',
    --   bg = '#00a040',
    -- })
    vim.api.nvim_set_hl(0, 'SpectreDir', {
      fg = '#a3a3a3',
      bg = '#000000',
    })
    vim.api.nvim_set_hl(0, 'SpectreFile', {
      fg = '#c085fe',
      bg = '#000000',
    })
    vim.api.nvim_set_hl(0, 'SpectreCurrent', {
      fg = '#000000',
      bg = '#ffb342',
    })

    vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufEnter', 'WinEnter', 'InsertLeave', 'BufWritePost' }, {
      callback = function()
        if state.is_open and state.total_item then
          clear_file_highlight()
          local async_id = state.async_id
          for _, item in pairs(state.total_item) do
            if state.async_id ~= async_id then
              return
            end
            ui.render_file(state.total_item[item.c_line], false)
          end
        else
          vim.api.nvim_buf_clear_namespace(0, config.namespace, 0, -1)
        end
      end,
    })
  end,
}

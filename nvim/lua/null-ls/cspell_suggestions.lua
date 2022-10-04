local helpers = require('null-ls.helpers')
local null_ls = require('null-ls')

local has_cspell_diagnostic = function(bufnr, row, col)
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = row - 1 })
  for _, diag in pairs(diagnostics) do
    if (diag.source == 'cspell') and (diag.col <= col and col <= diag.end_col) then
      return true
    end
  end

  return false
end

local generator_factory = helpers.generator_factory({
  command = 'cspell',
  args = function(params)
    local bufnr = params.bufnr
    local ft = params.ft
    local col = params.col
    local row = params.row

    local should_add_suggestions = has_cspell_diagnostic(bufnr, row, col)

    local args = {
      'lint',
      '--no-color',
      '--no-summary',
      '--no-progress',
      '--language-id',
      ft,
      '--config',
      vim.fn.expand('~/dotfiles/cspell/cspell.yaml'),
      'stdin',
    }

    if should_add_suggestions then
      args = vim.list_extend(args, { '--show-suggestions' })
    end

    return args

  end,
  to_stdin = true,
  ignore_stderr = true,
  check_exit_code = function(code)
    return code <= 1
  end,
  runtime_condition = function(params)
    return has_cspell_diagnostic(params.bufnr, params.row, params.col)
  end,
  on_output = function(params, done)
    local bufnr = params.bufnr
    local col = params.col
    local row = params.row
    local lnum = row - 1
    local output = params.output

    local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })
    if vim.tbl_isempty(diagnostics) then
      return done()
    end

    local diagnostic = {}
    for _, diag in pairs(diagnostics) do
      if (diag.source == 'cspell') and (diag.col <= col and col <= diag.end_col) then
        diagnostic = diag
        break
      end
    end

    if vim.tbl_isempty(diagnostic) then
      return done()
    end


    local lines = {}
    for l in output:gmatch('[^\r\n]+') do
      table.insert(lines, l)
    end

    local diag_pos = { row = tonumber(diagnostic.row), col = tonumber(diagnostic.col) + 1 }
    local result = {}
    for _, line in ipairs(lines) do

      local results = { line:match(".*:(%d+):(%d+)%s*-%s*(.*%((.*)%))%s*Suggestions:%s*%[(.*)%]%c?") }

      local group = { "row", "col", "message", "_quote", "_suggestions" }
      local entry = {}
      for i, m in ipairs(results) do
        entry[group[i]] = m
      end
      entry.row = tonumber(entry.row)
      entry.col = tonumber(entry.col)

      local entry_pos = { row = entry.row, col = entry.col }
      if diag_pos.row == entry_pos.row and diag_pos.col == entry_pos.col then

        local suggestions = {}
        if entry['_suggestions'] then
          for sug in entry['_suggestions']:gmatch("[^, ]+") do
            table.insert(suggestions, sug)
          end
        end
        entry.suggestions = suggestions
        entry.misspelled = entry['_quote']

        result = entry
        break
      end
    end


    if vim.tbl_isempty(result.suggestions) then
      return done()
    end

    local actions = {}

    for _, suggestion in ipairs(result.suggestions) do
      table.insert(actions, {
        title = 'Use "' .. suggestion .. '"',
        action = function()
          vim.api.nvim_buf_set_text(
            diagnostic.bufnr,
            diagnostic.lnum,
            diagnostic.col,
            diagnostic.end_lnum,
            diagnostic.end_col,
            { suggestion }
          )
        end,
      })
    end

    return done(actions)

  end,
})


local cspell_suggestions = {
  name = 'cspell_suggestions',
  filetypes = {},
  disabled_filetypes = { 'NvimTree' },
  method = null_ls.methods.CODE_ACTION,
  generator = generator_factory,
}

null_ls.register(cspell_suggestions)

local helpers = require('null-ls.helpers')
local null_ls = require('null-ls')

local Diagnostic = {
  new = function(diagnostic)
    local obj = vim.deepcopy(diagnostic)

    obj.is_empty = function(self)
      return vim.tbl_isempty(self)
    end

    obj.position = function(self)
      return {
        row = tonumber(self.row),
        col = tonumber(self.col) + 1
      }
    end

    return obj
  end
}

local Diagnostics = {
  new = function(bufnr, row)
    local obj = {}

    obj.diagnostics = vim.diagnostic.get(bufnr, { lnum = row - 1 })

    obj.is_empty = function(self)
      return vim.tbl_isempty(self.diagnostics)
    end

    obj.is_under_cursor = function(self, col)
      for _, diag in ipairs(self.diagnostics) do
        if (diag.source == 'cspell') then
          if (diag.col <= col) and (col <= diag.end_col) then
            return true
          end
        end
      end

      return false
    end

    obj.find_by_col = function(self, col)
      for _, diag in ipairs(self.diagnostics) do
        if (diag.source == 'cspell') then
          if (diag.col <= col) and (col <= diag.end_col) then
            return Diagnostic.new(diag)
          end
        end
      end

      return {}
    end

    return obj
  end
}


local CSpells = {
  new = function(list)
    local obj = {}
    obj.list = list

    obj.find_by_diagnostic = function(self, diagnostic)
      local diag_pos = diagnostic:position()

      for _, item in ipairs(self.list) do
        if diag_pos.row == item.row and diag_pos.col == item.col then
          return item
        end
      end

      return {}
    end

    return obj
  end
}

local CSpell = {
  new = function(str)
    local parsed = { str:match(".*:(%d+):(%d+)%s*-%s*(.*%((.*)%))%s*Suggestions:%s*%[(.*)%]%c?") }

    local cspell = {}
    local group = { "row", "col", "message", "_quote", "_suggestions" }
    for i, m in ipairs(parsed) do
      cspell[group[i]] = m
    end
    cspell.row = tonumber(cspell.row)
    cspell.col = tonumber(cspell.col)

    local suggestions = {}
    if cspell['_suggestions'] then
      for suggestion in cspell['_suggestions']:gmatch("[^, ]+") do
        table.insert(suggestions, suggestion)
      end
    end
    cspell.suggestions = suggestions
    cspell.misspelled = cspell['_quote']

    return cspell
  end
}

local CommandOutput = {
  new = function(output)
    local obj = {}

    obj.output = output

    obj.to_cspells = function(self)
      local list = {}
      for line in self.output:gmatch('[^\r\n]+') do
        table.insert(list, CSpell.new(line))
      end

      return CSpells.new(list)
    end

    return obj
  end
}

local generator_factory = helpers.generator_factory({
  command = 'cspell',
  args = function(params)
    local bufnr = params.bufnr
    local ft = params.ft
    local col = params.col
    local row = params.row

    local should_add_suggestions = Diagnostics.new(bufnr, row):is_under_cursor(col)

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
    return Diagnostics.new(params.bufnr, params.row):is_under_cursor(params.col)
  end,
  on_output = function(params, done)
    local bufnr = params.bufnr
    local col = params.col
    local row = params.row
    local output = params.output

    local diagnostics = Diagnostics.new(bufnr, row)
    if diagnostics:is_empty() then
      return done()
    end

    local diagnostic = diagnostics:find_by_col(col)

    if diagnostic:is_empty() then
      return done()
    end

    local cspells = CommandOutput.new(output):to_cspells()

    local cspell = cspells:find_by_diagnostic(diagnostic)

    if vim.tbl_isempty(cspell.suggestions) then
      return done()
    end

    local actions = {}

    for _, suggestion in ipairs(cspell.suggestions) do
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

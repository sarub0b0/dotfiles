local helpers = require("null-ls.helpers")
local null_ls = require("null-ls")

local Diagnostic = {
  new = function(diagnostic)
    local obj = vim.deepcopy(diagnostic)

    obj.is_empty = function(self)
      return vim.tbl_isempty(self)
    end

    obj.position = function(self)
      return {
        row = tonumber(self.row),
        col = tonumber(self.col) + 1,
      }
    end

    return obj
  end,
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
        if diag.source == "cspell" then
          if (diag.col <= col) and (col <= diag.end_col) then
            return true
          end
        end
      end

      return false
    end

    obj.find_by_col = function(self, col)
      for _, diag in ipairs(self.diagnostics) do
        if diag.source == "cspell" then
          if (diag.col <= col) and (col <= diag.end_col) then
            return Diagnostic.new(diag)
          end
        end
      end

      return {}
    end

    return obj
  end,
}

local CSpellMisspelled = {
  new = function(str)
    local obj = {}

    obj.misspelled = str:match(".*%((.*)%)")

    return obj
  end,
}

local CSpellSuggestion = {
  new = function(str)
    local obj = {}

    obj.suggestion = str:match("^%s+-%s+(.*)")

    obj.is_empty = function(self)
      return self.suggestion == "" or self.suggestion == nil
    end

    obj.is_matched = function(self)
      return not self:is_empty()
    end

    return obj
  end,
}

local CommandOutput = {
  new = function(output)
    local obj = {}

    obj.output = output

    obj.lines = function(self)
      return self.output:gmatch("[^\r\n]+")
    end

    return obj
  end,
}

local generator_factory = helpers.generator_factory({
  command = "cspell",
  args = function(params)
    local bufnr = params.bufnr
    local ft = params.ft
    local col = params.col
    local row = params.row

    local diagnostic = Diagnostics.new(bufnr, row):find_by_col(col)
    local cspell = CSpellMisspelled.new(diagnostic.message)

    return {
      "suggestions",
      "--no-color",
      "--language-id",
      ft,
      "--config",
      vim.fn.expand("~/dotfiles/cspell/cspell.yaml"),
      cspell.misspelled,
    }
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

    local suggestions = {}
    for line in CommandOutput.new(output):lines() do
      local suggestion = CSpellSuggestion.new(line)

      if suggestion:is_matched() then
        table.insert(suggestions, suggestion.suggestion)
      end
    end

    if vim.tbl_isempty(suggestions) then
      return done()
    end

    local diagnostic = Diagnostics.new(bufnr, row):find_by_col(col)

    local actions = {}
    for _, suggestion in ipairs(suggestions) do
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
  name = "cspell_suggestions",
  filetypes = {},
  disabled_filetypes = { "NvimTree" },
  method = null_ls.methods.CODE_ACTION,
  generator = generator_factory,
}

null_ls.register(cspell_suggestions)

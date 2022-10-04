local helpers = require('null-ls.helpers')
local null_ls = require('null-ls')


local cspell_append = function(word)

  local cspell_file = vim.fn.expand('~/dotfiles/cspell/user.txt')
  local file = io.open(cspell_file, 'a+')

  if not file then
    vim.notify(
      'failed to open ' .. cspell_file,
      vim.log.levels.ERROR,
      {}
    )
    return
  end

  file:write(word .. "\n")
  file:close()

  vim.notify(
    '"' .. word .. '" is appended to user dictionary.',
    vim.log.levels.INFO,
    {}
  )
  if vim.o.modifiable then
    vim.cmd('edit!')
  end
end

local cspell_custom_actions = {
  name = 'cspell_add_word',
  method = null_ls.methods.CODE_ACTION,
  filetypes = {},
  disabled_filetypes = { 'NvimTree' },
  generator = {
    fn = function(params)
      local lnum = params.row - 1
      local col = params.col

      local bufnr = params.bufnr
      local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

      local word = ''
      local regex = '^Unknown word %((%w+)%)$'
      for _, diag in pairs(diagnostics) do
        if diag.source == "cspell" and
            diag.col <= col and col <= diag.end_col and
            string.match(diag.message, regex) then

          word = string.gsub(diag.message, regex, '%1'):lower()
          break
        end
      end

      if word == '' then
        return nil
      end

      return {
        {
          title = 'Append "' .. word .. '" to user dictionary',
          action = function()
            cspell_append(word)
          end
        }
      }
    end
  }
}

null_ls.register(cspell_custom_actions)

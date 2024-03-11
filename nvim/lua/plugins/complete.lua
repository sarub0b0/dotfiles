return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dmitmel/cmp-cmdline-history',
      'davidsierradz/cmp-conventionalcommits',
      'saadparwaiz1/cmp_luasnip',
      'f3fora/cmp-spell',
      'windwp/nvim-autopairs',
      'onsails/lspkind.nvim',
    },
    config = function(_, opts)
      local cmp = require('cmp')
      cmp.setup(opts)

      local search_cmdline = { '@', '/', '?' }
      for _, cmd in pairs(search_cmdline) do
        cmp.setup.cmdline(cmd, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'cmdline_history' }
          },
          {
            { name = 'buffer' }
          }
        })
      end

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
        }, {
          -- { name = 'cmdline_history' },
        })
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            }
          }, {
          name = "conventionalcommits"
        } })
      })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    opts = function(_, opts)
      local has_words_before = function()
        local cursor_position = vim.api.nvim_win_get_cursor(0)
        local line, col = unpack(cursor_position)
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      local cmp = require('cmp')

      return {
        formatting = {
          format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            menu = ({
              cmdline = '[CmdLine]'
            })
          })
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = cmp.config.sources(
          {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            {
              name = 'buffer',
              option = {
                get_bufnrs = function()
                  return vim.api.nvim_list_bufs()
                end
              }
            },
            { name = 'path' },
            { name = 'spell' },
          }
        ),
        mapping = cmp.config.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-1),
          ['<C-f>'] = cmp.mapping.scroll_docs(1),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-j>'] = cmp.mapping(function(fallback)
            ----------------------
            -- luasnip
            ----------------------
            local luasnip = require('luasnip')
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-k>'] = cmp.mapping(function(fallback)
            local luasnip = require('luasnip')
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' })
        })
      }
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' }
      }
    }
  },
  {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
      }
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim", -- for curl, log wrapper
    },
    opts = {
      debug = false,
      -- See Configuration section for rest
      window = {
        layout = "float",
      }
    },
  }
}

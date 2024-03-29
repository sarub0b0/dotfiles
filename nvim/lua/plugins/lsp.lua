return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
      }
    }
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      'hrsh7th/nvim-cmp',
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)

      require('mason-lspconfig').setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            on_attach = on_attach,
          })
        end
      })
    end,
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    }
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.o.updatetime = 250
      vim.diagnostic.config({
        virtual_text = {
          source = "always", -- Or "if_many"
        },
        float = {
          source = "always", -- Or "if_many"
        },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    config = function()
      require('lsp/rust')
      require('lsp/yaml')
      require('lsp/clangd')
    end,
    keys = {
      {
        '<Space>f',
        function()
          local view = vim.fn.winsaveview()
          vim.lsp.buf.format { async = false }
          vim.fn.winrestview(view)
        end,
      }
    }
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    main = "null-ls",
    opts = function()
      local cspell_with = {
        disabled_filetypes = { 'NvimTree', 'neo-tree' },
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.WARN
        end,
        config = {
          create_config_file = true,
        }
      }

      return {
        sources = {
          -- null_ls.builtins.code_actions.gitsigns,

          require("null-ls").builtins.formatting.clang_format,

          require("null-ls").builtins.diagnostics.buf,
          require("null-ls").builtins.formatting.buf,
          --
          require("null-ls").builtins.completion.spell,

          require("null-ls").builtins.diagnostics.hadolint,

          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.formatting.markdownlint,

          require("null-ls").builtins.formatting.prettier,
          require("null-ls").builtins.formatting.terraform_fmt,

          require("null-ls").builtins.formatting.shfmt,
        },
        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup("NullLsFormatting", {})

          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                local view = vim.fn.winsaveview()
                vim.lsp.buf.format({ bufnr = bufnr, async = false })
                vim.fn.winrestview(view)
              end,
            })
          end
        end,
      }
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      'nvimtools/none-ls.nvim',
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
      automatic_setup = true,
    }
  },
  'simrat39/rust-tools.nvim',
  {
    'nvimdev/lspsaga.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    event = { "LspAttach" },
    opts = {
      lightbulb = {
        enable = false,
      },
      implement = {
        enable = true,
      },
    },
    keys = function()
      return {
        { 'K',          '<cmd>Lspsaga hover_doc<CR>' },
        { 'gl',         '<cmd>Lspsaga finder<CR>' },
        { '<Space>ca',  '<cmd>Lspsaga code_action<CR>',                                                                       mode = { 'n', 'v' } },
        { '<Space>rn',  '<cmd>Lspsaga rename<CR>' },
        { 'gd',         '<cmd>Lspsaga goto_definition<CR>' },
        { 'gD',         '<cmd>Lspsaga peek_definition<CR>' },
        { 'gt',         '<cmd>Lspsaga goto_type_definition<CR>' },
        { 'gT',         '<cmd>Lspsaga peek_type_definition<CR>' },
        { "[g",         '<cmd>Lspsaga diagnostic_jump_prev<CR>' },
        { "]g",         '<cmd>Lspsaga diagnostic_jump_next<CR>' },
        { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
        { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>" },
        { "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>" },
        { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>" },
        { "<leader>o",  "<cmd>Lspsaga outline<CR>", },
        { "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>" },
        { "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>" },
        { '[G',         function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, silent = true },
        { ']G',         function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, silent = true },
        { '\\\\',       '<cmd>Lspsaga term_toggle<CR>',                                                                       mode = { 'n', 't' } },
      }
    end
  }
}

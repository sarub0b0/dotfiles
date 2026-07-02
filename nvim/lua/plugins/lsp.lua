return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = function()
      local rubocop_config = require("conform").get_formatter_config("rubocop")

      return {
        formatters_by_ft = {
          javascript = { "biome", "prettierd", "prettierd", stop_after_first = true },
          javascriptreact = { "biome", "prettierd", "prettierd", stop_after_first = true },
          typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
          ruby = { "bundle_rubocop", "rubocop", "rufo", stop_after_first = true },
          json = { "biome", "jq" },
          lua = { "stylua", stop_after_first = true },
          markdown = { "markdownlint", stop_after_first = true },
        },
        default_format_opts = {
          lsp_format = "fallback",
        },
        format_on_save = {
          timeout_ms = 5000,
        },
        log_level = vim.log.levels.ERROR,
        formatters = {
          bundle_rubocop = {
            cwd = require("conform.util").root_file({ "Gemfile" }),
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, rubocop_config.args),
            exit_codes = { 0, 1 },
          },
        },
      }
    end,
    keys = {
      {
        "<Space>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "single",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {},
    },
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
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })
    end,
    keys = function()
      local toggle_inlay_hints = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end

      return {
        { "<Space>ih", toggle_inlay_hints, desc = "Toggle inlay hints" },
        {
          "K",
          function()
            return vim.lsp.buf.hover()
          end,
          desc = "Hover",
        },
        { "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
        { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
        { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
        { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        {
          "gK",
          function()
            return vim.lsp.buf.signature_help()
          end,
          desc = "Signature Help",
        },
        {
          "<c-k>",
          function()
            return vim.lsp.buf.signature_help()
          end,
          mode = "i",
          desc = "Signature Help",
        },
        { "<Space>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "x" } },
        { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
        { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "x" } },
        { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "davidmh/cspell.nvim",
    },
    opts = function()
      local cspell = require("cspell")
      local cspell_config = {
        -- config = {},
        disabled_filetypes = { "neo-tree" },
        diagnostics_postprocess = function(diag)
          diag.severity = vim.diagnostic.severity.HINT
        end,
        condition = function()
          return vim.fn.executable("cspell") == 1
        end,
      }

      return {
        sources = {
          cspell.diagnostics.with(cspell_config),
          cspell.code_actions.with(cspell_config),
          -- null_ls.builtins.code_actions.gitsigns,

          -- require("null-ls").builtins.formatting.clang_format,

          require("null-ls").builtins.diagnostics.buf,
          -- require("null-ls").builtins.formatting.buf,
          --
          -- require("null-ls").builtins.completion.spell,

          require("null-ls").builtins.diagnostics.hadolint,

          require("null-ls").builtins.diagnostics.markdownlint,
          -- require("null-ls").builtins.formatting.markdownlint,

          -- require("null-ls").builtins.formatting.prettier,
          -- require("null-ls").builtins.formatting.terraform_fmt,

          -- require("null-ls").builtins.formatting.shfmt,
        },
      }
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    opts = {
      ensure_installed = {},
      automatic_installation = false,
      automatic_setup = true,
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^9", -- Recommended
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          enable_clippy = true,
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "stable",
    config = true,
  },
  {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
    keys = {
      {
        "<leader>fy",
        function()
          require("schema-companion").select_schema()
        end,
        mode = "n",
        desc = "Choose YAML Schema",
      },
    },
  },
}

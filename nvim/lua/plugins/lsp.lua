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
          typescript = { "prettierd", "prettier", stop_after_first = true },
          typescriptreact = { "prettierd", "prettier", stop_after_first = true },
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
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()

          capabilities.textDocument.foldingRange = {
            dynamicregistration = false,
            lineFoldingOnly = true,
          }

          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })
    end,
    opts = {
      ensure_installed = {},
      automatic_installation = false,
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
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    config = function()
      require("lsp/clangd")
    end,
    keys = function()
      local toggle_inlay_hints = function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end

      return {
        { "<Space>ih", toggle_inlay_hints, desc = "Toggle inlay hints" },
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
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
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
      local diagnostic_goto_prev_error = function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end

      local diagnostic_goto_next_error = function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end

      local term_toggle = function()
        local cmd = vim.o.shell

        if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
          if vim.fn.executable("powershell.exe") == 1 then
            cmd = "powershell.exe"
          end
        end

        require("lspsaga.floaterm"):open_float_terminal({ cmd })
      end

      return {
        { "K", "<cmd>Lspsaga hover_doc<CR>" },
        { "gl", "<cmd>Lspsaga finder<CR>" },
        { "<Space>ca", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" } },
        { "<Space>rn", "<cmd>Lspsaga rename<CR>" },
        { "gd", "<cmd>Lspsaga goto_definition<CR>" },
        { "gD", "<cmd>Lspsaga peek_definition<CR>" },
        { "<leader>gt", "<cmd>Lspsaga goto_type_definition<CR>" },
        { "<leader>gT", "<cmd>Lspsaga peek_type_definition<CR>" },
        { "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
        { "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>" },
        { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
        { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>" },
        { "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>" },
        { "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>" },
        { "<leader>o", "<cmd>Lspsaga outline<CR>" },
        { "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>" },
        { "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>" },
        { "[G", diagnostic_goto_prev_error, silent = true },
        { "]G", diagnostic_goto_next_error, silent = true },
        { "\\\\", term_toggle, mode = { "n", "t" } },
      }
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
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
    config = function()
      require("crates").setup()
    end,
  },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ft = { "yaml" },
    keys = {
      { "<leader>fy", ":Telescope yaml_schema<CR>", mode = "n", desc = "Choose YAML Schema" },
    },
    config = function(_, opts)
      local cfg = require("yaml-companion").setup(opts)
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension("yaml_schema")
    end,
    opts = function()
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- capabilities.textDocument.foldingRange = {
      --   dynamicregistration = false,
      --   lineFoldingOnly = true,
      -- }

      return {
        -- log_level = "debug",
        builtin_matchers = {
          -- Detects Kubernetes files based on content
          kubernetes = { enabled = true },
          cloud_init = { enabled = true },
        },
        -- Additional schemas available in Telescope picker
        schemas = {
          {
            name = "GitLab CI",
            uri = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json",
          },
          {
            name = "DevSpace",
            uri = "https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json",
          },
          {
            name = "Kustomization",
            uri = "https://json.schemastore.org/kustomization.json",
          },
          {
            name = "Kubernetes 1.22.4",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
          },
          {
            name = "Kubernetes 1.28.0",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone-strict/all.json",
          },
        },
        lspconfig = {
          -- capabilities = capabilities,
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          settings = {
            yaml = {
              format = {
                enable = true,
              },
              schemas = {
                -- ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
                --   "/**/.gitlab-ci.yml",
                --   "/**/.gitlab/*.y*ml"
                -- },
                -- ["https://raw.githubusercontent.com/loft-sh/devspace/main/devspace-schema.json"] = {
                --   "/**/devspace*.yaml"
                -- },
                -- ["https://json.schemastore.org/kustomization.json"] = {
                --   "/**/kustomization.yaml"
                -- },
              },
              customTags = {
                "!reference sequence",
              },
              -- trace = {
              --   server = "debug"
              -- },
            },
          },
        },
      }
    end,
  },
}

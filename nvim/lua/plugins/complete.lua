return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "dmitmel/cmp-cmdline-history",
      "zbirenbaum/copilot-cmp",
      "davidsierradz/cmp-conventionalcommits",
      "saadparwaiz1/cmp_luasnip",
      "f3fora/cmp-spell",
      "windwp/nvim-autopairs",
      "onsails/lspkind.nvim",
    },
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      local mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = {
          c = cmp.mapping.select_next_item(),
        },
        ["<C-p>"] = {
          c = cmp.mapping.select_prev_item(),
        },
      })

      local search_cmdline = { "@", "/", "?" }
      for _, cmd in pairs(search_cmdline) do
        cmp.setup.cmdline(cmd, {
          mapping = mapping,
          sources = {
            { name = "cmdline_history" },
            { name = "buffer" },
          },
        })
      end

      cmp.setup.cmdline(":", {
        mapping = mapping,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          {
            name = "conventionalcommits",
          },
        }),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
    opts = function(_, opts)
      local has_words_before = function()
        local cursor_position = vim.api.nvim_win_get_cursor(0)
        local line, col = unpack(cursor_position)
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      return {
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            show_labelDetails = true,
            symbol_map = {
              Copilot = "",
            },
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              cmdline = "[CmdLine]",
            },
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "path" },
          { name = "spell" },
        }),
        mapping = cmp.config.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-1),
          ["<C-f>"] = cmp.mapping.scroll_docs(1),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-j>"] = cmp.mapping(function(fallback)
            ----------------------
            -- luasnip
            ----------------------
            local luasnip = require("luasnip")
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function(fallback)
            local luasnip = require("luasnip")
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
      },
    },
  },
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     vim.g.copilot_filetypes = {
  --       gitcommit = true,
  --       markdown = true,
  --       yaml = true,
  --     }
  --   end,
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
      },
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim", -- for curl, log wrapper
    },
    build = "make tiktoken",
    keys = {
      {
        "<leader>cct",
        "<cmd>CopilotChatToggle<CR>",
        desc = "Copilot Chat Toggle",
      },
      {
        "<leader>ccc",
        "<cmd>CopilotChatCommit<CR>",
        desc = "Copilot Chat Commit",
      },
    },
    opts = function(_, opts)
      local prompts = require("CopilotChat.config.prompts")

      prompts.Commit.prompt =
        "変更のコミットメッセージを commitizen の規約に従って英語と日本語でそれぞれ作成してください。タイトルは50文字以内、メッセージは72文字で折り返してください。gitcommit コードブロックとしてフォーマットしてください。説明は日本語で書いてください。"
      prompts.Docs.prompt = "選択したコードにドキュメントコメントを追加してください。"
      prompts.Explain.prompt = "選択したコードの説明を文章の段落として作成してください。"
      prompts.Fix.prompt =
        "このコードには問題があります。問題を特定し、修正したコードを書き直してください。何が問題だったのか、どのように修正したのかを説明してください。"
      prompts.Optimize.prompt =
        "選択したコードを最適化し、パフォーマンスと可読性を向上させてください。最適化の戦略と変更の利点を説明してください。"
      prompts.Review.prompt = "選択したコードをレビューしてください。"
      prompts.Tests.prompt = "コードのテストを生成してください。"

      return {
        debug = false,
        model = "claude-3.7-sonnet",
        -- See Configuration section for rest
        chat_autocomplete = false,
        window = {
          layout = "float",
          width = 0.7,
          height = 0.7,
        },
        mappings = {
          complete = {
            detail = "Use @<Tab> or /<Tab> for options.",
            insert = "<S-Tab>",
          },
        },
        prompts = prompts,
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    opts = {},
  },
}

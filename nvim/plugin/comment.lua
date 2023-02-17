require('Comment').setup({
  sticky = false,
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

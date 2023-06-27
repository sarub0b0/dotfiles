for _, value in ipairs({ 'Comment', 'ts_context_commentstring' }) do
  local ok, _ = pcall(require, value)
  if not ok then
    print(value .. ' is not installed.')
    return
  end
end

require('Comment').setup({
  sticky = false,
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

return {
  {
    'j-hui/fidget.nvim',
    opts = {
      progress = {
        lsp = {
          progress_ringbuf_size = 1024,
        }
      },
      notification = {
        window = {
          winblend = 0, -- &winblend for the window
        },
      }
    }
  }
}

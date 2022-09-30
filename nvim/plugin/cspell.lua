if vim.fn.filereadable('~/dotfiles/cspell/user.txt') ~= 1 then
  io.popen('mkdir -p ~/dotfiles/cspell')
  io.popen('touch ~/dotfiles/cspell/user.txt')
end

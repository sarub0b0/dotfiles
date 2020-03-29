
all: vim neovim tmux zsh anyenv kubectl-prompt

.PHONY: vim
vim:
	@echo '===================================='
	@echo '  Create symbolic links for vim'
	@echo '===================================='
	-rm -rf $(HOME)/.vim
	-rm -rf $(HOME)/.vimrc
	ln -sf $(HOME)/dotfiles/vimrc $(HOME)/.vim
	ln -sf $(HOME)/dotfiles/vimrc/init.vim $(HOME)/.vimrc

.PHONY: neovim
neovim:
	@echo '===================================='
	@echo '  Create symbolic links for neovim '
	@echo '===================================='
	-rm -rf $(HOME)/.config/nvim
	ln -sf $(HOME)/dotfiles/vimrc $(HOME)/.config/nvim


.PHONY: tmux
tmux:
	@echo '===================================='
	@echo '  Create symbolic links for tmux '
	@echo '===================================='
	ln -sf $(HOME)/dotfiles/tmux.conf $(HOME)/.tmux.conf

.PHONY: zsh
zsh:
	@echo '===================================='
	@echo '  Create symbolic links for tmux '
	@echo '===================================='
	ln -sf $(HOME)/dotfiles/zshrc $(HOME)/.zshrc
	# @echo "Install zplugin"
	# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"


.PHONY: anyenv
anyenv:
	@echo '===================================='
	@echo '  Download anyenv and anyenv-update'
	@echo '===================================='
	git clone --depth 1 https://github.com/anyenv/anyenv ~/.anyenv
	~/.anyenv/bin/anyenv init
	if [ -d $(HOME)/.anyenv/plugins ]; then mkdir -p $(HOME)/.anyenv/plugins; fi;
	-git clone --depth 1 https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update

.PHONY: kubectl-prompt
kubectl-prompt:
	@echo '===================================='
	@echo '  Download zsh-kubectl-prompt '
	@echo '===================================='
	-git clone --depth 1 https://github.com/superbrothers/zsh-kubectl-prompt.git $(HOME)/.zsh-kubectl-prompt

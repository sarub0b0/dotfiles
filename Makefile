
all: vim neovim tmux zsh anyenv kubectl-prompt gcloud-prompt docker-completion clang-format markdownlintrc

.PHONY: rust-install
rust-install:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

.PHONY: neovim-install
neovim-install:
	apt-get install -y software-properties-common
	add-apt-repository ppa:neovim-ppa/unstable
	apt-get update
	apt-get install -y neovim

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
	if [ -d $(HOME)/.anyenv/plugins ]; then mkdir -p $(HOME)/.anyenv/plugins; fi;
	-git clone --depth 1 https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update

.PHONY: kubectl-prompt
kubectl-prompt:
	@echo '===================================='
	@echo '  Download zsh-kubectl-prompt'
	@echo '===================================='
	-git clone --depth 1 https://github.com/superbrothers/zsh-kubectl-prompt.git $(HOME)/.zsh-kubectl-prompt

.PHONY: gcloud-prompt
gcloud-prompt:
	@echo '===================================='
	@echo '  Download zsh-gcloud-prompt'
	@echo '===================================='
	-git clone --depth 1 https://github.com/ocadaruma/zsh-gcloud-prompt.git $(HOME)/.zsh-gcloud-prompt

.PHONY: docker-completion
docker-completion:
	@echo '===================================='
	@echo '  Setup docker-completion for MacOS'
	@echo '===================================='
	if [ "$(shell uname)" = 'Darwin' ]; then ln -sf /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion ./zsh/completions/_docker fi


.PHONY: clang-format
clang-format:
	ln -sf $(HOME)/dotfiles/clang-format $(HOME)/.clang-format

.PHONY: markdownlintrc
markdownlintrc:
	ln -sf $(HOME)/dotfiles/markdownlintrc $(HOME)/.markdownlintrc


.PHONY: starship
starship:
	ln -sf $(HOME)/dotfiles/starship.toml $(HOME)/.config/starship.toml

.PHONY: krew
krew:
	cd "$(shell mktemp -d)" && \
	curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
	tar zxvf krew.tar.gz && \
	$(eval KREW := ./krew-$(shell uname | tr '[:upper:]' '[:lower:]')_$(shell uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$$/arm/' -e 's/aarch64$$/arm64/')) \
	$(KREW) install krew


.PHONY: krew-update
krew-update:
	kubectl krew update

.PHONY: kubectx
kubectx: krew-update
	kubectl krew update
	kubectl krew install ctx
	kubectl krew install ns

.PHONY: git-config
git-config:
	git config --global alias.st status
	git config --global alias.co checkout
	git config --global alias.br branch

.PHONY: powerlevel10k
powerlevel10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
	ln -sf $(HOME)/dotfiles/p10k.zsh ~/.p10k.zsh

.PHONY: asdf
asdf:
	git clone --depth=1 https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
	ln -sf $(HOME)/dotfiles/asdfrc ~/.asdfrc

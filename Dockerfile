# syntax=docker/dockerfile:1

FROM debian:bullseye

RUN <<EOF
apt-get update
apt-get install -y \
    sudo \
    curl \
    git \
    file \
    procps \
    zsh \
    build-essential \
    man \
    python \
    gettext \
    xz-utils
EOF


RUN <<EOF
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -G sudo -m debian -s /usr/bin/zsh
EOF

USER debian
ENV USER debian

COPY <<EOF /home/debian/.zprofile
if [ -e /home/debian/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/debian/.nix-profile/etc/profile.d/nix.sh;
fi
EOF


RUN <<EOF
curl -L https://nixos.org/nix/install | sh -s - --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-env --set-flag priority 10 nix
nix-shell '<home-manager>' -A install
EOF

WORKDIR /home/debian/dotfiles

COPY . .

RUN <<EOF
mkdir -p ~/.config/nixpkgs
ln -sf ~/dotfiles/home.nix ~/.config/nixpkgs/home.nix
EOF

SHELL ["sh", "-l", "-c"]
RUN home-manager switch

RUN <<EOF
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
EOF


WORKDIR /home/debian

CMD ["zsh", "-l"]

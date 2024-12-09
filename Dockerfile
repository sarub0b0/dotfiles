# syntax=docker/dockerfile:1

FROM debian

RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    file \
    procps \
    zsh \
    python3 \
    build-essential

RUN <<EOF
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
useradd -G sudo -m debian -s /usr/bin/zsh
EOF

USER debian
ENV USER=debian

COPY --chown=debian:debian <<EOF /home/debian/.zprofile
if [ -e /home/debian/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/debian/.nix-profile/etc/profile.d/nix.sh;
fi
EOF

WORKDIR /home/debian/dotfiles
SHELL ["zsh", "-l", "-c"]

RUN <<EOF
curl -sL https://nixos.org/nix/install | sh -s - --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
EOF

COPY --chown=debian:debian <<EOF /home/debian/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

COPY --chown=debian:debian . /home/debian/dotfiles


RUN <<EOF
rm -rf ~/.config/home-manager
ln -sf ~/dotfiles/home-manager/ ~/.config/home-manager
mkdir ~/.asdf
home-manager switch --impure
EOF

RUN nvim --headless -c "+Lazy! sync" -c "MasonUpdate" +qa

WORKDIR /home/debian

CMD ["zsh", "-l"]

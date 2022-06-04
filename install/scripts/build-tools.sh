#!/bin/bash

os=$(sed -n 's/^NAME="\(.*\)"/\1/p' /etc/os-release)

sudo=""
[ "$(whoami)" != "root" ] && sudo="sudo"

case $(uname) in
    Linux)
        case $os in
            openSUSE*)
                eval "$sudo zypper install -y gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel libopenssl-devel libyaml-devel gdbm-devel ruby-devel"
                ;;
            Ubuntu*)
                eval "$sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev autoconf bison libyaml-dev libncurses5-dev libgdbm6 libgdbm-dev libdb-dev"
                ;;
            *)
                exit 1
                ;;
        esac
        ;;
    *)
        exit 1
        ;;
esac



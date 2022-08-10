#!/bin/bash

set -u

is_exist () {
    builtin command -v "$1" > /dev/null
}


pre_install () {

   local pm="invalid"
   local sudo=""
   [ "$(whoami)" != "root" ] && sudo="sudo"

   # package manager
   os=$(sed -n 's/^NAME="\(.*\)"/\1/p' /etc/os-release)

   case $(uname) in
        Linux)
            case $os in
                openSUSE*)
                    eval "$sudo zypper install -y -t pattern devel_basis"
                    pm=zypper
                    ;;
                Ubuntu*)

                    eval "$sudo apt-get install -y build-essential"
                    pm="apt-get"
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

    for package in curl git tar ruby gzip patch
    do
        ! is_exist $package && eval "$sudo $pm install -y $package"
    done
}

#############
#  install  #
#############

pre_install

source ./scripts/brew.sh
source ./scripts/asdf.sh

set +e

source ./scripts/utils.sh
source ./scripts/build-tools.sh

source ./scripts/python.sh
source ./scripts/ruby.sh
source ./scripts/nodejs.sh
source ./scripts/neovim.sh

#!/bin/bash

brew install neovim --HEAD

gem install neovim

asdf global python 2.7.18
pip install -U pip
pip install -U pynvim

asdf global python latest
pip install -U pip
pip install -U pynvim

npm i -g neovim

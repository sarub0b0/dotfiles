#!/bin/bash

# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest
asdf reshim ruby

# unset RUBY_CONFIGURE_OPTS

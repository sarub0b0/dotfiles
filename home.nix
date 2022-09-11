{ config, pkgs, lib, ... }:

let
  dot_dir = "${config.home.homeDirectory}/dotfiles";

  nvim-treesitter-nightly = with pkgs; (
    vimPlugins.nvim-treesitter.withPlugins (_: tree-sitter.allGrammars)
  ).overrideAttrs (old: {
    version = "2022-09-11";
    src = fetchFromGitHub {
      owner = "nvim-treesitter";
      repo = "nvim-treesitter";
      rev = "f53a5a6471994693e7e550b29627ca73d91e0536";
      sha256 = "sha256-FebRBPX4lpLw6Tj7wYiVUpzejAkK3tU1JQIc+6icSMo=";
    };
  });

  opts = import "${dot_dir}/nix";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # utils
    ghq
    bat
    dive
    fping
    fswatch
    git-filter-repo
    git-lfs
    htop
    ncdu
    scc
    unison
    wget
    fzf
    ripgrep
    tldr
    choose
    cheat
    bottom
    delta

    # programming languages
    asdf-vm
    rustup
    go

    # zsh
    zsh-autosuggestions
    zsh-powerlevel10k
    zsh-z

  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      source ${dot_dir}/tmux.conf
    '';
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      source ${dot_dir}/zshrc
      source ${pkgs.asdf-vm}/etc/profile.d/asdf-prepare.sh
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        bindkey '^T' transpose-chars
      fi
    '';
    plugins = with pkgs; [
      {
        file = "powerlevel10k.zsh-theme";
        name = "powerlevel10k";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        file = "p10k.zsh";
        name = "powerlevel10k-config";
        src = "${dot_dir}";
      }
      {
        file = "zsh-z.plugin.zsh";
        name = "z";
        src = "${zsh-z}/share/zsh-z";
      }
    ];
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-nightly
    ];

    extraConfig = ''
      source ${dot_dir}/vimrc/init.vim
      set rtp^=${dot_dir}/vimrc
      set rtp+=${dot_dir}/vimrc/after
      let g:coc_config_home = "${dot_dir}/vimrc"
    '';
  };

  programs.vim = {
    enable = true;

    extraConfig = ''
      set rtp^=${dot_dir}/vimrc
      set rtp+=${dot_dir}/vimrc/after
      source ${dot_dir}/vimrc/init.vim
    '';
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "${opts.git.userEmail}";
    userName = "${opts.git.userName}";
    aliases = {
      co = "checkout";
      st = "status";
      br = "branch";
      cm = "commit";
      mt = "mergetool";
      dt = "difftool";
      fe = "fetch";
    };
    ignores = lib.strings.splitString "\n" (builtins.readFile "${dot_dir}/gitignore");
    extraConfig = {
      core = {
        editor = "nvim";
      };
      ghq = {
        root = "~/work/ghq";
      };
      diff = {
        tool = "nvimdiff";
      };
      difftool = {
        nvimdiff = {
          tool = "nvimdiff";
        };
      };
      merge = {
        ff = "only";
        tool = "nvimdiff";
      };
      mergetool = {
        keepBackup = "false";
      };
      mergetool = {
        nvimdiff = {
          cmd = "nvim -d -c \"4wincmd w | wincmd J\" \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\"";
        };
      };
      pull = {
        ff = "only";
      };
      credential = {
        "https://source.developers.google.com" = {
          helper = "gcloud.sh";
        };
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.file.".clang-format".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/clang-format";
  home.file.".asdfrc".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/asdfrc";
  home.file.".markdownlintrc".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/markdownlintrc";


}

# vim:sw=2:et:sts=2:ts=2:

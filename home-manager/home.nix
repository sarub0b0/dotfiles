{ config, pkgs, lib, ... }:

let
  dot_dir = "${config.home.homeDirectory}/dotfiles";

in
{
  imports = [
    ./nix
  ];
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
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # utils
    ghq
    dive
    fswatch
    git-filter-repo
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
    fd
    jq
    stern

    # programming languages
    asdf-vm
    rustup
    go

    # c
    clang-tools

    # zsh

    # vim
  ];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      source ${dot_dir}/tmux.conf
    '';
  };

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    completionInit = "autoload -Uz compinit && compinit -C";
    syntaxHighlighting = {
      enable = true;
    };
    history = {
      share = false;
    };
    envExtra = ''
      # export GITSTATUS_NUM_THREADS=4
      export KUBECTL_EXTERNAL_DIFF=delta
    '';
    initExtraFirst = ''
      [[ -n "$ZPROF" ]] && zmodload zsh/zprof
      # Keep at the top of this file.
      [[ -f "$HOME/.zsh/pre.zsh" ]] && builtin source "$HOME/.zsh/pre.zsh"
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
      source ${dot_dir}/zshrc
      source ${pkgs.asdf-vm}/etc/profile.d/asdf-prepare.sh
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        bindkey '^T' transpose-chars
      fi

      # Keep at the bottom of this file.
      [[ -f "$HOME/.zsh/post.zsh" ]] && builtin source "$HOME/.zsh/post.zsh"

      if [[ -n "$ZPROF" ]] && (which zprof > /dev/null 2>&1); then
          zprof
      fi
    '';
    plugins = with pkgs; [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = "${zsh-powerlevel10k}/share/zsh-powerlevel10k";
      }
      {
        name = "powerlevel10k-config";
        src = config.lib.file.mkOutOfStoreSymlink "${dot_dir}";
        file = "p10k.zsh";
      }
      {
        name = "z";
        src = "${zsh-z}/share/zsh-z";
        file = "zsh-z.plugin.zsh";
      }
    ];
  };


  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;

    extraPackages = with pkgs; [
      tree-sitter
    ];

    extraLuaPackages = ps: [
      ps.tiktoken_core
      ps.rustaceanvim
    ];
  };

  programs.vim = {
    enable = true;

    extraConfig = ''
      source ${dot_dir}/vim/init.vim
    '';
  };

  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      st = "status";
      br = "branch";
      cm = "commit";
      mt = "mergetool";
      dt = "difftool";
      fe = "fetch";
      pu = "pull";
      sw = "switch";
      rs = "restore";
    };
    ignores = lib.strings.splitString "\n" (builtins.readFile "${dot_dir}/gitignore");
    extraConfig = {
      core = {
        editor = "nvim";
        quotepath = "false";
        pager = "delta";
      };
      ghq = {
        root = "~/work/ghq";
      };
      delta = {
        navigate = "true";
        light = "false";
        side-by-side = "true";
      };
      interactive = {
        diffFilter = "delta --color-only";
      };
      diff = {
        tool = "nvimdiff";
        context = 7;
        algorithm = "histogram";
        colorMoved = "true";
        indentHeuristic = "true";
      };
      difftool = {
        nvimdiff = {
          tool = "nvimdiff";
        };
      };
      merge = {
        ff = "false";
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

  programs.direnv = {
    enable = true;
  };

  home.file.".clang-format".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/clang-format";
  home.file.".asdfrc".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/asdfrc";
  home.file.".markdownlintrc".source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/markdownlintrc";

  xdg.configFile."cspell/cspell.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/cspell/cspell.json";
  };

  xdg.configFile."kitty/kitty.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/kitty.conf";
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/nvim";
  };
}

# vim:sw=2:et:sts=2:ts=2:

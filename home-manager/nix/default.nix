{ config, pkgs, lib, ... }:

let
  dot_dir = "${config.home.homeDirectory}/dotfiles";

in
{

  home.packages = with pkgs; [
    gotools
    kubernetes-helm
  ];

  programs.tmux = pkgs.lib.mkForce {
    enable = false;
  };

  xdg.configFile."tmux/tmux.conf" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dot_dir}/tmux.conf";
  };

  programs.git = {
    userName = "kosay";
    userEmail = "ekr59uv25@gmail.com";
  };
}

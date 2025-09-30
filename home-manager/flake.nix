{
  description = "Home Manager configuration of kosay";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    serena.url = "github:oraios/serena";
  };

  outputs =
    {
      flake-utils,
      neovim-nightly-overlay,
      nixpkgs,
      home-manager,
      serena,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        username = builtins.getEnv "USER";
        overlays = [
          neovim-nightly-overlay.overlays.default
          (final: prev: {
            serena = serena.packages.${system}.default;
          })
        ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      {
        packages.homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home.nix
          ];
        };
      }
    );
}

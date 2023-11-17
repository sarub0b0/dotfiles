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
  };

  outputs = { flake-utils, neovim-nightly-overlay, nixpkgs, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        username = builtins.getEnv "USER";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration
          {
            inherit pkgs;

            modules = [
              ./home.nix
              ({
                nixpkgs.overlays = [ neovim-nightly-overlay.overlay ];
              })
            ];
          };
      }
    );
}

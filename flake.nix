{
  description = "Very Very Reproduciable Flakes that Zenith Apporve!";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.55.4-b";
    };
    waybar = {
      url = "github:alexays/waybar/master";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      qtEnv = pkgs.qt6.env "qt6-simc-${pkgs.qt6.qtbase.version}" [
        pkgs.qt6.qtbase
        pkgs.qt6.qtwebengine
        pkgs.qt6.qttools
        pkgs.qt6.qtdeclarative
        pkgs.qt6.qt5compat
        pkgs.qt6.qtwebchannel
        pkgs.qt6.qtpositioning
      ];
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs qtEnv; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };

}

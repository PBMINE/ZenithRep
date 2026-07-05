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
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };

}

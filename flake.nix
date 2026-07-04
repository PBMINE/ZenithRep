{
  description = "Very Very Reproduciable Flakes that Zenith Apporve!";

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/main";
    };
    waybar = {
      url = "github:alexays/waybar/master";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
       lib = nixpkgs.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./configuration.nix ];
      };
    };
  };

}

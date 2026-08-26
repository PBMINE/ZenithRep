{
  description = "Very Very Reproduciable Flakes that Zenith Apporve!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    waybar.url = "github:alexays/waybar/71a122037359bf11a5847af49f9e53397079ddcc";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mesa-git-nix = {
      url = "github:Daaboulex/mesa-git-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    davinci-resolve-patched.url = "path:/home/pbmine/davinci-resolve-patched";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      davinci-resolve-patched,
      quickshell,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit quickshell; };
              backupFileExtension = "backup";
              users.pbmine = import ./home.nix;
              users.nullnormal = import ./nullhome.nix;
            };
          }
        ];
      };
    };
}

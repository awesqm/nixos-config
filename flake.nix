{
  description = "nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      zn = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # ./configuration.nix
          ./system/main.nix
          ./gui/main.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.toxa = import ./home.nix;
          }
        ];
      };

    };
  };
}

{
  description = "System flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nvf.url = "github:notashelf/nvf";
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { home-manager, nixpkgs, nvf, ... } : let
    home = {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.marko = import ./home.nix;
    };
    sharedModules = [
      home-manager.nixosModules.home-manager
      nvf.nixosModules.default
      ./configuration.nix
      ./packages.nix
      ./network.nix
      ./flutter.nix
      ./gnome.nix
      ./nvim.nix
      ./bash.nix
      home
    ];
  in { 
    nixosConfigurations = {
      intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = sharedModules ++ [
          ./hardware-intel.nix
        ];
      };
      amd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = sharedModules ++ [
          ./hardware-amd.nix
        ];
      };
    };
  };
}

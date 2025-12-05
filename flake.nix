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
      nvf.nixosModules.default
      ./nvim.nix
      ./bash.nix
    ];
    serverModules = sharedModules ++ [
      ./server.nix
    ];
    clientModules = sharedModules ++ [ 
      home-manager.nixosModules.home-manager
      ./configuration.nix 
      ./packages.nix 
      ./flutter.nix
      ./gnome.nix 
      home
    ];
  in { 
    nixosConfigurations = {
      intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = clientModules ++ [ ./hardware-intel.nix ];
      };
      amd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = clientModules ++ [ ./hardware-amd.nix ];
      };
      hetzner = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = serverModules ++ [ ./hardware-hetzner.nix ];
      };
    };
  };
}

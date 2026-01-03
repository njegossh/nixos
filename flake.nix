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
      home-manager.users.marko = import ./client/home.nix;
    };
    sharedModules = [
      nvf.nixosModules.default
      ./shared/vim.nix
      ./shared/bash.nix
    ];
    serverModules = sharedModules ++ [
      ./server/adblock.nix
      ./server/configuration.nix
      ./server/i2p.nix
      ./server/searx.nix
      ./server/ssh.nix
      ./server/wireguard.nix
      ./server/peertube.nix
    ];
    clientModules = sharedModules ++ [ 
      home-manager.nixosModules.home-manager
      ./client/configuration.nix 
      ./client/packages.nix 
      ./client/flutter.nix
      ./client/chicago-95.nix
      ./client/gnome.nix 
      home
    ];
  in { 
    nixosConfigurations = {
      intel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = clientModules ++ [ ./client/hardware-intel.nix ];
      };
      amd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = clientModules ++ [ ./client/hardware-amd.nix ];
      };
      hetzner = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = serverModules ++ [ ./server/hardware-hetzner.nix ];
      };
    };
  };
}

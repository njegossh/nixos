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
      home-manager.users.marko.imports = [
        ./client/home/configuration.nix 
        ./client/home/firefox.nix 
        ./client/home/gnome.nix
      ];
    };
    sharedModules = [
      nvf.nixosModules.default
      ./shared/bash.nix
      ./shared/vim.nix
    ];
    serverModules = sharedModules ++ [
      ./server/configuration.nix
      ./server/wireguard.nix
      ./server/adblock.nix
      ./server/searx.nix
      ./server/minio.nix
      ./server/ssh.nix
      ./server/i2p.nix
    ];
    clientModules = sharedModules ++ [ 
      home-manager.nixosModules.home-manager
      ./client/configuration.nix 
      ./client/packages.nix 
      ./client/flutter.nix
      ./client/minio.nix
      ./client/ssh.nix
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

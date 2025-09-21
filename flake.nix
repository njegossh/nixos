{
  description = "System flake";
  inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nvf.url = "github:notashelf/nvf";
  };
  outputs = { nix-flatpak, nixpkgs, nvf, ... } : let
    sharedModules = [
        nix-flatpak.nixosModules.nix-flatpak
				nvf.nixosModules.default
        ./configuration.nix
				./packages.nix
        ./network.nix
				./flutter.nix
				./gnome.nix
				./nvim.nix
        ./bash.nix
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

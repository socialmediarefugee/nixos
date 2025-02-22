{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#    home-manager.url = "github:nix-community/home-manager";
#    home-manager.inputs.nixpkgs.follows = "nixpkgs";
#    plasma-manager.url = "github:nix-community/plasma-manager";
#    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
#    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    inputs@{
      nixpkgs,
#      home-manager,
#      plasma-manager,
      ...
    }:
    {
      nixosConfigurations = {
        pikon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
	  ];
        };
      };
    };
}

# Drawing from Misterio77/nix-starter-configs and 
# ryan4yin/nix-config/blob/i3-kickstarter/
{
  description = "Entrypoint Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    systems.url = "github:nix-systems/default";
    nixos-hardware = {
      #url = "git+file:./nixos-hardware";
      url = "github:/socialmediarefugee/nixos-hardware";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Basic theming
    nix-colors.url = "github:misterio77/nix-colors";
    # Alternative window manager
    hyprland.url = "github:hyprwm/Hyprland";
    nix-mcp-servers.url = "github:aloshy-ai/nix-mcp-servers";
   };

  outputs = { self, nixpkgs, home-manager, plasma-manager, systems, nixos-hardware, ... } @ inputs: 
  let 
    inherit (self) outputs;
    lib = nixpkgs.lib ; #// home-manager.lib ;
    forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs (import systems) (
      system:
        import nixpkgs {
          inherit system;
          config.settings.experimental-features = ["nix-command" "flakes"];
          config.allowUnfree = false;
        }
    );
  in {
    inherit lib;
    nixosModules = import ./modules;

    packages = forEachSystem(pkgs: import ./packages {inherit pkgs;});
    shells = forEachSystem(pkgs: import ./shells {inherit pkgs;});

    # Because we run stuff
    programs.nix-ld.enable = true;

    # Optimize the store periodically
    nix.optimise = true;

    fmt = forEachSystem(pkgs: pkgs.nixfmt-rfc-style);

    # Machine configs
    # TODO: Tie this to machine unique id's or serial numbers
    # TODO: Abstract the machine configuration
    nixosConfigurations = {
      caprica = lib.nixosSystem {
        specialArgs = { 
          inherit inputs outputs;
        };
        modules = [
          ./hosts/caprica  # Sets up the caprica host
          ./hosts/caprica/modules  # Host specific modules
          ./modules # System modules
        ];
      };
    };
  };
}

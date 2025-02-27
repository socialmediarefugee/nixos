{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      plasma-manager,
      hyprland,
      ...
    }:
    {
      nixosConfigurations = {
        pikon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
	          ./modules/virtualisation.nix
      	    ./modules/services.nix
            {

              users.users.root = {
                packages = with nixpkgs.lib; [
                  nixpkgs.legacyPackages.x86_64-linux.tcpdump
                  nixpkgs.legacyPackages.x86_64-linux.nixos-option
                  nixpkgs.legacyPackages.x86_64-linux.strace
                ];
              };

              users.users.sunshine = {
                isNormalUser = true;
                description = "Nunya Bidness";
                home = "/home/sunshine";
                extraGroups = [
                  "networkmanager"
                  "wheel"
                  "video"
                  "libvirtd"
                 ];
              };
  
              users.users.apollo = {
                isNormalUser = true;
                home = "/home/apollo";
                description = "Apollo Hyprland";
                extraGroups = [ 
                  "networkmanager" 
                  "wheel" 
                  "video" 
                  "libvirtd" 
                ];
              };

              users.users.boomer = {
                isNormalUser = true;
                home = "/home/boomer";
                description = "Boomer (Terminal)";
                extraGroups = [ "networkmanager"];
                shell = nixpkgs.lib.getExe nixpkgs.legacyPackages.x86_64-linux.bash;
              };
            }

            {
              environment.systemPackages = with nixpkgs.lib; [
                nixpkgs.legacyPackages.x86_64-linux.nano
              ];

              programs.hyprland = {
                enable = true;
#                packages = hyprland.packages.x86_64-linux.hyprland;
              };

              #Working on a terminal only login account

              #services.displayManager.sddm.settings.Users.UserBlacklist = [ "boomer"];
              services.flatpak.enable = true;

/*
              services.getty.autoLogin = {
                enable = true;
                user = "boomer";
                tty = "tty1";
              };
*/

/*
              home-manager.modules.home-manager.users.root = {pkgs,...} : {

              };
              modules.home-manager.users.apollo = {pkgs, ...}: {
                wayland.windowManager.hyperland.enable = true;
              };

              modules.home-manager.users.boomer = { pkgs, ...}: {
                programs.bash.enable = true;
              };
*/
            } 
          ]; # modules
        }; # pikon
      };
  };
}

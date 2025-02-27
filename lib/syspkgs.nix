{ pkgs, lib, ... }:
let
  # Import the system package list
  systemPackages = (import /etc/system-packages.nix).systemPackages;
  # Function to check if a package is already installed system-wide
  shouldInstall = pkg: ! (builtins.elem pkg.name systemPackages);
in {
  home.packages = lib.filter shouldInstall [
    pkgs.htop  # Only installed if not in systemPackages
    pkgs.firefox
  ];
}
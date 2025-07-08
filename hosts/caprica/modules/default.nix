{lib, pkgs, ...}:
{
  imports = [ 
    ./networking.nix
    ./plasma.nix
    ./misc.nix
    ./services.nix
  ];

  services.flatpak.enable = true;
}

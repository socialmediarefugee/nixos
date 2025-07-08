{lib, pkgs, ...} :
{

  imports = [
    ./virtualisation.nix
    ./xserver.nix
    ./idevices.nix
    ./gaming.nix
    ./emacs.nix
    ./development.nix
  ];

  programs.firefox.enable = true;

}

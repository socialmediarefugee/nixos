{pkgs,config, lib, ...}:

{
  user.users.adama = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [
      "git"
      "libvirt"
      "libvirtd"
      "networkmanager"
      "network"
      "wheel"
      "video"
    ];
    packages = [pkgs.home-manager];
  };
}

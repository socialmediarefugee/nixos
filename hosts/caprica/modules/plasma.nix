{lib,pkgs,...}: {
  # System level KDE Plasma configuration

  environment.systemPackages = with pkgs; [
    kdePackages.plymouth-kcm
    kdePackages.plasma-disks
    kdePackages.partitionmanager
    kdePackages.plasma-browser-integration

  ];
}

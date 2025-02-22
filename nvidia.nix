{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  hardware.graphics = {
    enable = true;
  };

  # Enable NVIDIA drivers
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; # Set to true for open-source drivers (optional)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # Enable PRIME for hybrid graphics (Intel + NVIDIA)
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau
      mesa
    ];
  };

  # Allow switching between Intel and NVIDIA
  hardware.nvidia.prime = {
    #enable = true;
    #sync.enable = true; # Alternative: offload.enable = true;
    intelBusId = "pci@0.2.0";
    nvidiaBusId = "pci@1.0.0";
  };

  # Kernel parameters for NVIDIA
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

  # Ensure NVIDIA modules load correctly
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
}

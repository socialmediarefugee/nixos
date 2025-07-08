{pkgs,nixpkgs,...}:
{
  # 32-bit graphics support (needed for Vulkan + Wine)

  nixpkgs.config.allowUnfree = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux;[
        libva
        libvdpau
        alsa-lib
      ];
    };
   };

  programs = {
    steam.enable =  true;
    gamemode.enable = true;
  };

  # (Optional but recommended) Vulkan stuff
  #
  # environment.systemPackages = with pkgs; [
  #   vulkan-loader
  #   vulkan-tools
  #   gamemode
  #   gamescope
  #   mangohud
  #   bottles
  #   lutris
  #   wineWowPackages.stagingFull
  #   winetricks
  #   gst_all_1.gstreamer
  #   gst_all_1.gst-plugins-good
  #   gst_all_1.gst-plugins-bad
  #   gst_all_1.gst-plugins-ugly
  # ];
  #
}


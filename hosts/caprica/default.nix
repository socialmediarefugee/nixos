{config, pkgs, nixos-hardware, ...} :
{
  #Caprica Host Hardware definition

  imports = [
    ../../modules/nixos  # Sets the defaults for Nix.
    ./hardware-configuration.nix 
    "${builtins.fetchGit{ 
      url = "https://github.com/socialmediarefugee/nixos-hardware.git";
      rev = "ede8dad8ed574e038c753051bb50e58388045aba";
      
     }
    }/omen/15-ek1013dx"
    #nixos-hardware.omen.15.ek1013
    ./modules
  ];

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
     nvidia = {
       modesetting.enable = true;
       powerManagement.enable = false;
       open = false;
       nvidiaSettings = true;
       prime = {
         offload.enable = false;
         sync.enable = true;
         intelBusId = "PCI:0:2:0";
         nvidiaBusId = "PCI:1:0:0";
       };
     };
  };

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelModules = [
    "firewire-core"
    "firewire-ohci"
    "firewire-sbp2"
  ];

  time.timeZone = "America/Chicago";

  # Networking
  networking.hostName = "caprica";

  #Audio
  security.rtkit.enable = true; # audio uses this.
  # TODO: Determine if we want to move all or part of this somewhere else.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # OR
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.

  users.defaultUserShell = pkgs.bash;

  users.users.adama = {
    isNormalUser = true;
    description = "adama";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # NTS: Keep systemPackages to utilities only
  environment.systemPackages = with pkgs; [
    pciutils # information about machine
    git # Used everywhere
    wget # Used by lots of other utilities
    curl # ditto
    unzip # ditto
    sox # for speech
    alsa-utils # for speech
    #nvi # Berkely (new) vi
    neovim # Nano sucks. 
    ripgrep # Enhanced grep, used by Neovim
    fd  # Enhanced Find. Also used by Neovim
    bat  # A better cat
    lsd # A better ls
    xclip # basic clipboard support. Neovim.
    wl-clipboard # Clipboard support for wayland. Nvim again.
    gcc # Because everything seems to depened upon it.
    pkg-config # --- Easy.  Didn't want to run into a problem installing w home-manager  TODO: Revisit this
  ];

  services.openssh.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?

}

{lib, pkgs, ...} :
{

  environment.systemPackages = with pkgs; [
    kdePackages.plasma-firewall
    opensnitch
    nixos-firewall-tool
    nfs-utils
    rpcbind
#    dnsmasq
  ];
  
  services = {
    opensnitch = {
      enable = false;
      settings = {
        Firewall = "nftables";
        InterceptUnknown = true;
        LogLevel = 2;
        ProcMonitorMethod = "ebpf";
      };
    };

    avahi = {
      enable = true;
    };

    samba = {
      enable = true;
      openFirewall = true;
      nmbd.enable = true;
    };

    nfs = { 
      server = {
        enable = true;
        exports = ''
          /home/adama/Documents/Guest 192.168.122.0/24(rw,sync,no_subtree_check)
        '';
      };
    };



    
  };

  networking = {
    firewall = {
      enable = false;
      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } #kdeconnect
      ];
      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } #kdeconnect
      ];
      allowedTCPPorts = [ 6560 ]; # speech-dispatcher (speechd)
      allowedUDPPorts = [ 6560 ]; 
    };
    nftables.enable = false;
    nameservers = ["8.8.4.4" "8.8.8.8"];
  };
}

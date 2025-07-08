{config, pkgs, ...}:

{
  # Changing the old podman.enableNvidia to the following introduces new requirements
 
  #hardware.nvidia-container-toolkit.enable =  true;
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;

    libvirtd.qemu = {
    	swtpm.enable = true;
	    ovmf.packages = [ pkgs.OVMFFull.fd ];
    	runAsRoot = false;
    	package = pkgs.qemu_kvm;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };


    podman.enable = true;
    #podman.enableNvidia = true;

    docker = {
      enable = true;
    };

  };

  boot = {
    kernelModules = ["virtio_net" "virtio_blk" "virtio_pci" "virtio_scsi"];
    extraModprobeConfig = "options kvm_intel nested=1";
    extraModulePackages = with pkgs; [ virtiofsd ];
  };

  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    OVMFFull
    virt-manager
  ];

  /*

  environment.etc."libvirt/qemu.conf".text = ''
    virtiofsd_path = "${pkgs.qemu}/libexec/virtiofsd"
  '';
  */

  security.virtualisation = {
    flushL1DataCache = "always";
  };

  networking.firewall.trustedInterfaces = ["virb0" "br0"];
  programs.virt-manager.enable = true;

  # TODO:  Move this to more appropriate location.  For now, we are pers, not prod 
  users.users.adama.extraGroups = ["networkmanager" "libvirtd" "kvm" "qemu-libvirtd" "libvirt" "docker" ];
  users.extraGroups.docker.members = ["adama"];

/*
  systemd.services.run-partition-vm = {
    description = "Ubuntu VM";
    serviceConfig = {
      ExecStart = ''
        ${pkgs.qemu}/bin/qemu-system-x86_64 --enable-kvm -m 4096 -cpu host -drive file=/dev/nvme0n1p5,raw;
      '';
      Restart = "on-failure";
      wantedBy = [ "multi-user.target"];
    };

  };
*/
}

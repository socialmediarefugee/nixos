{config, pkgs, ...}:

{

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    libvirtd.qemu = {
    	swtpm.enable = true;
	ovmf.packages = [ pkgs.OVMFFull.fd ];
    	runAsRoot = false;
    	package = pkgs.qemu_kvm;
    };
  };

  boot = {
    kernelModules = ["kvm_intel" "virtio_net" "virtio_blk" "virtio_pci" "virtio_scsi"];
    extraModprobeConfig = "options kvm_intel nested=1";
    extraModulePackages = with pkgs; [ virtiofsd ];
  };


  environment.systemPackages = with pkgs; [
    qemu
    libvirt
    OVMFFull
  ];

  users.users.sunshine.extraGroups = ["networkmanager" "libvirtd" "kvm"];

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
}

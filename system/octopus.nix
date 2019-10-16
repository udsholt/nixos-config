{ config, lib, pkgs, ... }:

{
    system.stateVersion = "19.09";

    virtualisation.vmware.guest.enable = true;

    networking.hostName = "octopus";

    time.timeZone = "Europe/Copenhagen";

	  boot.loader.grub.enable = true;
	  boot.loader.grub.version = 2;
	  boot.loader.grub.device = "/dev/sda";

    boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/429c9801-dfb4-45ea-9204-d0d3dd4ae56b";
        fsType = "ext4";
    };

  	swapDevices = [
    	  { device = "/dev/disk/by-uuid/cc1fc00b-89ba-4689-a407-db6ccc70dc3d"; }
    ];

    nix.maxJobs = lib.mkDefault 4;


    # Host only network with static ipAddress allowed through firewall
    networking.interfaces.ens37.ipv4.addresses = [{ address = "192.168.220.100"; prefixLength = 24; }];
    networking.firewall = {
        enable = true;
        trustedInterfaces = ["ens37"];
    };
}

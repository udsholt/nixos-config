{ config, lib, pkgs, ... }:

{
    system.stateVersion = "19.03";

    virtualisation.vmware.guest.enable = true;

    networking.hostName = "cuttlefish";

    time.timeZone = "Europe/Copenhagen";

    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.device = "/dev/sda";

    boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
        device = "/dev/disk/by-uuid/8b33f2f1-6fd0-46da-a51b-fa11386abcaa";
        fsType = "ext4";
    };

  	swapDevices = [
    	{ device = "/dev/disk/by-uuid/e4a72735-04f9-40c8-b4f2-8fdf69f57a9a"; }
    ];

    nix.maxJobs = lib.mkDefault 4;

    # Host only network with static ipAddress allowed through firewall
    networking.interfaces.ens37.ipv4.addresses = [{ address = "192.168.253.100"; prefixLength = 24; }];
    networking.firewall = {
        enable = true;
        trustedInterfaces = ["ens37"];
    };
}



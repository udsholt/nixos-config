{ config, lib, pkgs, ... }:

{
  # Hostname definition
  networking.hostName = "toaster";
  networking.hostId = "8ce3d089";

  # Setup timzone
  time.timeZone = "Europe/Copenhagen";

  # Danish layout
  i18n = {
    consoleFont   = "lat9w-16";
    consoleKeyMap = "dk";
    defaultLocale = "en_US.UTF-8";
  };

  # Danish xserver
  services.xserver = {
    layout = "dk";
  };
  
   # Enable synaptics touchpad
  services.xserver.synaptics = {
    enable = true;
    tapButtons = false;
    vertEdgeScroll = true;
    twoFingerScroll = false;
  };

  # Pulse audio
  hardware.pulseaudio.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  # GRUB bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    version = 2;
  };

  # Filesystem layout
  fileSystems = [
    {
      mountPoint = "/";
      device = "/dev/disk/by-uuid/6aaf3077-261a-44b8-9723-b35862fd784b";
      fsType = "ext4";
    } {
      mountPoint = "/home";
      device = "/dev/disk/by-uuid/098b5c2a-2312-4c0d-8fc3-720fbc48ed99";
      fsType = "ext4";
    }
  ];

  # Swapfile
  swapDevices = [{ 
    device = "/var/swapfile";
    size = 4096; 
  }];

  # Generated by nixos-generate-config
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  nix.maxJobs = 2;
}

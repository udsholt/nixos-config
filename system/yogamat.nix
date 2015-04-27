# Nixos configuration for the toaster
{ config, lib, pkgs, ... }:

{
  # Hostname definition
  networking.hostName = "yogamat";
  networking.hostId = "044405fe";

  # wpa supplicant wireless interface (not used for wicd)
  networking.wireless.interfaces = [ "wlp0s26u1u4i2" ];

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
    additionalOptions = ''
      Option "SoftButtonAreas" "50% 0 82% 0 0 0 0 0"
      Option "SecondarySoftButtonAreas" "58% 0 0 15% 42% 58% 0 15%"
    '';
  };

  # Bootloader
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Filesystem layout (using efi boot)
  fileSystems = [
    {
      mountPoint = "/";
      device = "/dev/disk/by-uuid/7642e9ae-8b7f-44b2-ba78-2c7089d0e7eb";
      fsType = "ext4";
    } {
      mountPoint = "/boot";
      device = "/dev/disk/by-uuid/8E26-69CC";
      fsType = "vfat";
    } {
      mountPoint = "/home";
      device = "/dev/disk/by-uuid/252b0b7a-fe28-4de2-9490-00cfefa54ecb";
      fsType = "ext4";
    }
  ];

  # Swap 
  swapDevices = [{ 
    device = "/var/swapfile";
    size = 8192; 
  }];

  # TODO: What does this do?
  # Generated by nixos-generate-config
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" "8723au" ];
  boot.extraModulePackages = [ pkgs.rtl8723au ];

  nix.maxJobs = 4;
}

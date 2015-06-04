# Nixos configuration for the toaster
{ config, lib, pkgs, ... }:

{
  # Hostname definition
  networking.hostName = "kaaresyv";
  networking.hostId = "829af73f";
  
  # Bootloader
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use refind for dual booting
  #
  # Install with: 
  #   > sudo refind-install
  # 
  # From: http://www.rodsbooks.com/refind/installing.html
  #
  # In case of bus errors this might help 
  #   > sudo efibootmgr -c -l \\EFI\\refind\\refind_x64.efi -L rEFInd
  #
  environment.systemPackages = with pkgs; [
    refind
    efibootmgr
  ];
  
  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Filesystem layout
  fileSystems = [
      {
          mountPoint = "/";
          device = "/dev/disk/by-uuid/8235ad87-3695-43cf-883b-a8f06e7da212";
          fsType = "ext4";
      } {
          mountPoint = "/boot";
          device = "/dev/disk/by-uuid/AF65-ABFA";
          fsType = "vfat";
      } {
          mountPoint = "/home";
          device = "/dev/disk/by-uuid/6c589480-dcd7-405f-803a-ff1692099fcc";
          fsType = "ext4";
      } {
          mountPoint = "/mnt/barracuda_a";
          device = "/dev/disk/by-uuid/547C1DFB7C1DD896";
          fsType = "ntfs";
      } {
          mountPoint = "/mnt/barracuda_b";
          device = "/dev/disk/by-uuid/6612D69512D66A17";
          fsType = "ntfs";
      }
  ];

  # Figure out if i need swap later
  swapDevices = [ ];

  # Use nvidia binary driver
  # NOTE: this is required for i3bar to work...
  services.xserver = {
      videoDrivers = [ "nvidia" ];

      # Not yet supported
      /*
      inputClassSections = [''
          Identifier "Razer DeathAdder 2013 Slowdown"

          MatchIsPointer "true"
          MatchProduct   "Razer Razer DeathAdder 2013"

          Option "Device Accel Constant Deceleration" "1.6"
          Option "Device Accel Adaptive Deceleration" "1.0"
          Option "Device Accel Velocity Scaling"      "1.1"
      ''];
      */
  };
  
  # Has something to do with loading hardware
  imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];
  
  # Detected by nixos install
  boot.initrd.availableKernelModules = [ "xhci_hcd" "ehci_pci" "ahci" "usbhid" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  
  # 8 cores
  nix.maxJobs = 8;
}

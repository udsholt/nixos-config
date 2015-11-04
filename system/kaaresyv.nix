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

  # Setup xserver
  services.xserver = {

      exportConfiguration = true;

      # Use nvidia binary driver
      # NOTE: this is required for i3bar to work!
      videoDrivers = [ "nvidia" ];

      # Setup mouse.
      #
      # xinput dump of defaults
      #
      # Device 'Razer Razer DeathAdder 2013':
      #     Device Enabled (150):   1
      #     Coordinate Transformation Matrix (152): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
      #     Device Accel Profile (275): 0
      #     Device Accel Constant Deceleration (276):   1.000000
      #     Device Accel Adaptive Deceleration (277):   1.000000
      #     Device Accel Velocity Scaling (278):    10.000000
      #     Device Product ID (268):    5426, 55
      #     Device Node (269):  "/dev/input/event6"
      #     Evdev Axis Inversion (279): 0, 0
      #     Evdev Axes Swap (281):  0
      #     Axis Labels (282):  "Rel X" (160), "Rel Y" (161), "Rel Vert Wheel" (274)
      #     Button Labels (283):    "Button Left" (153), "Button Middle" (154), "Button Right" (155), "Button Wheel Up" (156), "Button Wheel Down" (157), "Button Horiz Wheel Left" (158), "Button Horiz Wheel Right" (159), "Button Side" (272), "Button Extra" (273), "Button Unknown" (271), "Button Unknown" (271), "Button Unknown" (271), "Button Unknown" (271)
      #     Evdev Scrolling Distance (284): 1, 1, 1
      #     Evdev Middle Button Emulation (285):    0
      #     Evdev Middle Button Timeout (286):  50
      #     Evdev Third Button Emulation (287): 0
      #     Evdev Third Button Emulation Timeout (288): 1000
      #     Evdev Third Button Emulation Button (289):  3
      #     Evdev Third Button Emulation Threshold (290):   20
      #     Evdev Wheel Emulation (291):    0
      #     Evdev Wheel Emulation Axes (292):   0, 0, 4, 5
      #     Evdev Wheel Emulation Inertia (293):    10
      #     Evdev Wheel Emulation Timeout (294):    200
      #     Evdev Wheel Emulation Button (295): 4
      #     Evdev Drag Lock Buttons (296):  0
      #
      # Old mouse setup:
      #
      #     xinput --set-prop 10 "Device Accel Constant Deceleration" 1.65
      #     xinput --set-prop 10 "Device Accel Adaptive Deceleration" 1
      #     xinput --set-prop 10 "Device Accel Velocity Scaling" 1.1
      #
      inputClassSections = [''
          Identifier "Razer DeathAdder 2013 Slowdown"

          MatchIsPointer "true"
          MatchProduct   "Razer Razer DeathAdder 2013"

          Option "Device Accel Constant Deceleration" "2.7"
          Option "Device Accel Adaptive Deceleration" "1.0"
          Option "Device Accel Velocity Scaling"      "1.6"
      ''];
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

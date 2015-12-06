{ config, lib, pkgs, ... }:

{
    # Hostname definition
    networking.hostName = "zenfoot";

    # The NixOS release to be compatible with for stateful data such as databases.
    system.stateVersion = "15.09";

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

    # Select internationalisation properties.
    i18n = {
        consoleFont = "Lat2-Terminus16";
        consoleKeyMap = "dk";
        defaultLocale = "en_US.UTF-8";
    };

    hardware = {
        pulseaudio.enable = true;
        bumblebee = {
            enable = true;
            driver = "nvidia";
        };
    };

    # Danish xserver
    services.xserver = {
        layout = "dk";
        exportConfiguration = true;
        # videoDrivers = [ "intel" ];
        #vaapiDrivers = [ pkgs.vaapiIntel pkgs.vaapiVdpau ];
        # videoDrivers = [ "nvidia" ];
        resolutions = [
            { x = 1920; y = 1080; }
            { x = 3840; y = 2160; }
            { x = 1600; y =  900; }
            { x = 1280; y =  720; }
        ];
    };

    # Enable synaptics touchpad
    services.xserver.synaptics = {
        enable = true;
        #tapButtons = false;
        vertEdgeScroll = true;
        twoFingerScroll = false;
    };

    # Filesystem layout
    fileSystems = [{
        mountPoint = "/";
        device = "/dev/disk/by-uuid/a0308e13-ea00-458a-a386-7ec7fbdef18d";
        fsType = "ext4";
    } {
        mountPoint = "/boot";
        device = "/dev/disk/by-uuid/1A9A-3C36";
        fsType = "vfat";
    }];

    # Figure out if i need swap later
    swapDevices = [ ];

    # Has something to do with loading hardware
    imports = [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    # 8 cores
    nix.maxJobs = 8;
}

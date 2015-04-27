# Manual wireless networking with wpa-gui
{ pkgs, ... }:

{
  # Add some basic stuff
  environment.systemPackages = with pkgs; [
    wpa_supplicant_gui
  ];

  networking = {
    wireless.enable = true;
    wireless.userControlled.enable = true;
  };
}
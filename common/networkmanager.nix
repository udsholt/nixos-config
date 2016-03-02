# Manual wireless networking with wpa-gui
{ pkgs, ... }:

{
    # https://nixos.org/wiki/Network_Manager
    networking.networkmanager.enable = true;
    services.dbus.enable = true;

    # nm-applet and themes
    environment.systemPackages = with pkgs; [
        pkgs.networkmanagerapplet

        pkgs.gnome.gnome_icon_theme
        pkgs.gnome3.dconf
        pkgs.gnome3.gnome_themes_standard
    ];
}


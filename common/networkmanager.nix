# Manual wireless networking with wpa-gui
{ pkgs, ... }:

{
    # https://nixos.org/wiki/Network_Manager
    networking.networkmanager.enable = true;
    services.dbus.enable = true;

    # nm-applet and themes
    environment.systemPackages = with pkgs; [
        networkmanagerapplet

        gnome3.dconf
        gnome.gnome_icon_theme
        gnome3.gnome_themes_standard
    ];

    # FIX:  https://github.com/NixOS/nixpkgs/issues/10689
    # TODO: remove once it hits unstable
    users.extraGroups = [{
      name = "nm-openvpn";
    }];
    users.extraUsers = [{
      name = "nm-openvpn";
    }];
}


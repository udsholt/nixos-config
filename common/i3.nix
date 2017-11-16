# i3 desktop config
{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        i3lock
        i3status
        dmenu
        dunst
        libnotify
    ];

    /*
    services.xserver = {
        enable = true;

        windowManager.airblader.enable = true;
        windowManager.default = "airblader";
    };
    */
    services.xserver = {
        enable = true;
        windowManager.i3.package = pkgs.i3-gaps;
        windowManager.i3.enable = true;
        windowManager.default = "i3";
    };
}

# i3 desktop config
{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        i3lock
        i3status
        dmenu
        dunst
        libnotify

        # https://github.com/unix121/i3wm-themer/blob/master/themes/Fire/.config/polybar/config
        # https://github.com/DaveDavenport/rofi/
        # https://github.com/jaagr/polybar
        rofi    # start with > rofi -show run
        polybar # looks nice...
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

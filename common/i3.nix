# i3 desktop config
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    i3lock
    i3status
    dmenu
  ];

  services.xserver = {
    enable = true;

    windowManager.airblader.enable = true;
    windowManager.default = "airblader";
  };
}

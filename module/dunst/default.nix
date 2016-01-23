# Dunst daemon.

{ config, lib, pkgs, ... }:

let
    cfg = config.services.dunst;
in
with lib;
{
    options = {
        services.dunst = {
            enable = mkOption {
                default = false;
                example = true;
                description = "Enable dunst";
            };
        };
    };

    config = mkIf config.services.dunst.enable {

        environment.systemPackages = [ pkgs.dunst ];

        systemd.services.dunst = {
            description = "dunst Daemon";
            wantedBy    = [ "multi-user.target" ];

            serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
        };

    };

}

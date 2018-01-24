{ config, pkgs, ... }:

{
    require = [
        ./system/gwyran.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix

        ./container/redis.nix
        ./container/stats.nix
    ];

    environment.systemPackages = with pkgs; [
        pkgs.vscode
        pkgs.gnumake
        pkgs.gcc
        
        pkgs.awscli
        pkgs.cqlsh
        #pkgs.terraform

        pkgs.gparted
        pkgs.dnsutils               # nslookup, dig, etc.
        pkgs.redis                  # redis-cli
        pkgs.influxdb               # influx (client)
        pkgs.redis-desktop-manager  # redis-desktop-manager
    ];

    #networking.extraHosts = "192.168.56.20 cassandra";

    virtualisation.docker.enable = true;
}

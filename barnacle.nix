{ config, pkgs, ... }:

{
    require = [
        ./system/barnacle.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/node.nix

        ./container/redis.nix
        ./container/stats.nix
    ];
    environment.systemPackages = with pkgs; [
      pkgs.awscli
      pkgs.cqlsh
      pkgs.gnumake
      pkgs.gcc
      pkgs.graphviz
      pkgs.docker_compose
      pkgs.siege
      pkgs.dnsutils               # nslookup, dig, etc.
      pkgs.redis                  # redis-cli
      pkgs.influxdb               # influx (client)
      pkgs.redis-desktop-manager  # redis-desktop-manager
      pkgs.python                 # dependecy for google gloud sdk
    ];

    networking.extraHosts = "192.168.56.20 cassandra";

    virtualisation.docker.enable = true;

    services.privoxy = {
        enable = true;
        listenAddress = "192.168.56.30:12345";
        extraConfig = ''
            debug 2
        '';
    };
}

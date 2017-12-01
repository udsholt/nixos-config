{ config, pkgs, ... }:

{
    require = [
        ./system/barnacle.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix
        ./common/nodejs.nix

        ./container/redis.nix
    ];

    environment.systemPackages = with pkgs; [
      pkgs.vscode
      pkgs.awscli
      pkgs.cqlsh
      pkgs.gnumake
      pkgs.gcc
      pkgs.protobuf3_2
      pkgs.terraform_0_10-full
      pkgs.graphviz
      pkgs.docker_compose
      pkgs.siege
      pkgs.dnsutils               # nslookup, dig, etc.
      pkgs.redis                  # redis-cli
      pkgs.redis-desktop-manager  # redis-desktop-manager
    ];

    networking.extraHosts = "192.168.56.20 cassandra";

    virtualisation.docker.enable = true;
}

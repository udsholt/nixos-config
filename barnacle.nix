{ config, pkgs, ... }:

{
    require = [
        ./system/barnacle.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix
    ];

    environment.systemPackages = with pkgs; [
      pkgs.vscode
      pkgs.awscli
      pkgs.cqlsh
    ];

    networking.extraHosts = "192.168.56.20 cassandra";
}

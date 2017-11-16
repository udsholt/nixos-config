{ config, pkgs, ... }:

{
    require = [
        ./system/gwyran.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/golang.nix
    ];

    environment.systemPackages = with pkgs; [
        pkgs.vscode
        pkgs.gnumake
        pkgs.awscli
        pkgs.cqlsh
        pkgs.terraform
    ];

    #networking.extraHosts = "192.168.56.20 cassandra";

    virtualisation.docker.enable = true;
}

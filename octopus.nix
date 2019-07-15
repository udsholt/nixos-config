{ config, pkgs, ... }:

{
    require = [
        ./system/octopus.nix

        ./common/user.nix
        ./common/base.nix
        ./common/desktop.nix
        ./common/i3.nix
        ./common/node.nix
        ./common/golang.nix
    ];

    # docker and docker-compose
    virtualisation.docker = {
      enable = true;
      extraOptions = "--log-level debug --debug";
    };

    environment.systemPackages = with pkgs; [
      pkgs.docker_compose
    ];
}

{ pkgs, config, ... }:

{
	virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    pkgs.docker_compose
  ];
}
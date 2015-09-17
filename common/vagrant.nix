{ pkgs, config, ... }:

with pkgs.lib;

{
	environment.systemPackages = with pkgs; [
	  	pkgs.vagrant
	  	pkgs.ansible
	];

    virtualisation.virtualbox = {
        host.enable = true;
    };
}
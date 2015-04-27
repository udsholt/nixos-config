{ pkgs, config, ... }:

with pkgs.lib;

{
	environment.systemPackages = with pkgs; [
	  	pkgs.vagrant
	  	pkgs.ansible
	];

	services.virtualboxHost = {
		enable = true;
	};
}
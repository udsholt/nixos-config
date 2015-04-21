{ config, pkgs, ... }:

{
  users.extraUsers = {
    udsholt = {
      uid = 1000;
      home = "/home/udsholt";
      shell = "/run/current-system/sw/bin/zsh";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}

# From: https://github.com/aszlig/vuizvui
#
# I have removed everything related to overrides
# and left the stuff that was required for custom
# packages.
pkgs:

with pkgs.lib;

let
    # I am still not entirely sure why pkgs = everything; is required here
    allPackages = (import ../package { pkgs = everything; }).custom;
    everything = pkgs // allPackages;

in
    allPackages

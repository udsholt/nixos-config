{ pkgs, config, ... }:

with pkgs.lib;

{
    # Setup *.lo to resolve to localhost
    # https://github.com/NixOS/nixos/blob/master/modules/services/networking/dnsmasq.nix
    services.dnsmasq = {
        enable = true;
        resolveLocalQueries = true;
        extraConfig = ''
            address=/lo/127.0.0.1
        '';
    };
}

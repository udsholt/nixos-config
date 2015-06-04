{ config, pkgs, ... }:

{
    # Enable plex
    services.plex = {
        enable = true;
    };

    # Open required ports
    # https://support.plex.tv/hc/en-us/articles/201543147-What-network-ports-do-I-need-to-allow-through-my-firewall-
    networking.firewall = {
        allowedTCPPorts = [
             3005 # Plex Companion
            32400 # Plex Media Server
            32469 # Plex DLNA Server
        ];
        allowedUDPPorts = [
             1900 # Plex DLNA Server
             5353 # Bonjour/Avahi network discovery
            32410 # GDM network discover
            32412 # ...
            32413 # ...
            32414 # ...
        ];
    };
}

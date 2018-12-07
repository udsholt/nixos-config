{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        steam
        steam-run
    ];

    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.support32Bit = true;

    # Open required ports in in-home streaming
    # https://support.steampowered.com/kb_article.php?ref=3629-RIAV-1617#howdoiuseit
    networking.firewall = {
        allowedTCPPorts = [ 27036 27037 ];
        allowedUDPPorts = [ 27031 27036 ];
    };
}
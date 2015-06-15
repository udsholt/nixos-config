{ pkgs, config, ... }:

with pkgs.lib;

{
    environment.systemPackages = with pkgs; [
        firefoxWrapper
        oraclejre8
    ];

    nixpkgs.config = {
        # https://gist.github.com/fooblahblah/707f20865d66a5e5878f
        packageOverrides = pkgs: rec {
            jre       = pkgs.oraclejre8;
            jdk       = pkgs.oraclejdk8;
            jdkdistro = pkgs.oraclejdk8distro;
        };

        # requires download of the file jdk-8u45-linux-x64.tar.gz from:
        #
        #    http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
        #
        # followed by:
        #
        #    nix-store --add-fixed sha256 jdk-8u45-linux-x64.tar.gz
        #
        firefox = {
            jre = true;
        };
    };
}

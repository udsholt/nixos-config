{ pkgs ? import <nixpkgs> {} }:

let

    # Define callPackage such that it will look in custom > pkgs
    callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.linuxPackages // pkgs.xlibs // pkgs.gnome // self);

    # Define custom packages
    self = {
        airblader    = callPackage ./airblader {};
        font-awesome = callPackage ./font-awesome {};
        sakura       = callPackage ./sakura {};
        # nsq          = callPackage ./nsq {};

        goimports = callPackage ./goimports {};
        gorerun   = callPackage ./gorerun {};
        gohelpers = callPackage ./gohelpers {};
    };
  
in {
    custom = self;
}

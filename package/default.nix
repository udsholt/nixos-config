
{ pkgs ? import <nixpkgs> {} }:

let

    # Define callPackage such that it will look in custom > pkgs
    callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.linuxPackages // pkgs.xlibs // pkgs.gnome // pkgs.pythonPackages // self);

    # Define custom packages
    self = {
        airblader       = callPackage ./airblader {};
        font-awesome    = callPackage ./font-awesome {};
        sakura          = callPackage ./sakura {};
        rtl8723au       = callPackage ./rtl8723au {};

        goimports = callPackage ./goimports {};
        gorerun   = callPackage ./gorerun {};
        gohelpers = callPackage ./gohelpers {};
        gostatus  = callPackage ./gostatus {};
    };
  
in {
    custom = self;
}

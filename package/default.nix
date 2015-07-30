
{ pkgs ? import <nixpkgs> {} }:

let

    # Define callPackage such that it will look in custom > pkgs
    callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.linuxPackages // pkgs.xlibs // pkgs.gnome // pkgs.pythonPackages // self);

    # Define custom packages
    self = rec {
        airblader     = callPackage ./airblader {};
        font-awesome  = callPackage ./font-awesome {};
        sakura        = callPackage ./sakura {};
        rtl8723au     = callPackage ./rtl8723au {};
        disque        = callPackage ./disque {};
        swfdec        = callPackage ./swfdec {};
        mlt-swf       = callPackage ./mlt-swf {};

        goimports = callPackage ./goimports {};
        gorerun   = callPackage ./gorerun {};
        gohelpers = callPackage ./gohelpers {};
        gostatus  = callPackage ./gostatus {};
    };
  
in {
    custom = self;
}


{ pkgs ? import <nixpkgs> {} }:

let

    # Define callPackage such that it will look in custom > pkgs
    callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.linuxPackages // pkgs.xlibs // pkgs.gnome // pkgs.pythonPackages // self);

    # callNightly = callPackage ./rust-nightly {};

    # Define custom packages
    self = rec {
        airblader    = callPackage ./airblader {};
        font-awesome = callPackage ./font-awesome {};
        sakura       = callPackage ./sakura {};
        rtl8723au    = callPackage ./rtl8723au {};
        disque       = callPackage ./disque {};
        swfdec       = callPackage ./swfdec {};
        mlt-swf      = callPackage ./mlt-swf {};
        pgl          = callPackage ./pgl {};
        sift         = callPackage ./sift {};
        moonlight    = callPackage ./moonlight {};
        forego       = callPackage ./forego {};
        goimports    = callPackage ./goimports {};
        gorerun      = callPackage ./gorerun {};
        gohelpers    = callPackage ./gohelpers {};
        gostatus     = callPackage ./gostatus {};
        premake5     = callPackage ./premake5 {};

        # rustNightly  = callNightly.rustc {
        #    date = "2015-11-14";
        #    hash = "0r5b055c6rad4k79j1qrfkyqv706zrab3xijn2wx6rpn5fs9zlw9";
        #};
        #cargoNightly = callNightly.cargo {
        #    date = "2015-11-14";
        #    hash = "1cz1glfp6d2phz7m6xnpsh22cpcb9r3n8js7i53brzglsasljxla";
        #};

        # TODO: this was a patch until unstable is updated, remove this as soon as that is the case
        #bumblebee    = callPackage ./bumblebee {
        #    nvidia_x11 = pkgs.linuxPackages.nvidia_x11;
        #    nvidia_x11_i686 = if pkgs.system == "x86_64-linux"
        #      then pkgs.pkgsi686Linux.linuxPackages.nvidia_x11.override { libsOnly = true; }
        #      else null;
        #    primusLib_i686 = if pkgs.system == "x86_64-linux"
        #      then pkgs.pkgsi686Linux.primusLib
        #      else null;
        #};
    };

in {
    custom = self;
}

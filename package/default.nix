# Local package definitions, adapted from:
#
#   Managing private Nix packages outside the Nixpkgs tree
#   http://sandervanderburg.blogspot.dk/2014/07/managing-private-nix-packages-outside.html
#
{ pkgs ? import <nixpkgs> {} }:

let
    # Define a callPackage function to be callPackageWith where the auto arguments
    # are the a combination of the self defined packages and the default nix packages.
    #
    # NOTE: self is prioritized over pkgs as it is specified last.
    #
    callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.xlibs // pkgs.gnome // pkgs.kde4 // self);

    # Custom package definitions
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

        gtksourceviewmm = callPackage ./gtksourceviewmm {};
        nemiver         = callPackage ./nemiver {};

        kdbg = callPackage ./kdbg {
            inherit (pkgs.kde4) kdelibs;
        };

        glsl-debugger = callPackage ./glsl-debugger {};
    };

in
    self


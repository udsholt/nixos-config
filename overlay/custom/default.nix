self: super:

{
    font-awesome = super.callPackage ./package/font-awesome {};

    cqlsh = super.callPackage ./package/cqlsh {};

    sakura = super.callPackage ./package/sakura {
        gtk = super.gnome2.gtk;
        vte = super.gnome2.vte;
    };

    gooutline    = super.callPackage ./package/gooutline {};
    gosymbols    = super.callPackage ./package/gosymbols {};
    gogetdoc     = super.callPackage ./package/gogetdoc {};
    gomodifytags = super.callPackage ./package/gomodifytags {};
    gopkgs       = super.callPackage ./package/gopkgs {};
    goreturns    = super.callPackage ./package/goreturns {};
    gotests      = super.callPackage ./package/gotests {};
    goimpl       = super.callPackage ./package/goimpl {};
    gorerun      = super.callPackage ./package/gorerun {};
    goforego     = super.callPackage ./package/goforego {};
    govendor     = super.callPackage ./package/govendor {};
    gotorch      = super.callPackage ./package/gotorch {};
}


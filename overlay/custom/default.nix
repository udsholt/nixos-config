self: super:

{
    font-awesome = super.callPackage ./package/font-awesome {};

    airblader = super.callPackage ./package/airblader {};

    cqlsh = super.callPackage ./package/cqlsh {};

    sakura = super.callPackage ./package/sakura {
        gtk = super.gnome2.gtk;
        vte = super.gnome2.vte;
    };
}


self: super:

{
    font-awesome = super.callPackage ./package/font-awesome {};

    cqlsh = super.callPackage ./package/cqlsh {};

    sakura = super.callPackage ./package/sakura {
        gtk = super.gnome2.gtk;
        vte = super.gnome2.vte;
    };
}


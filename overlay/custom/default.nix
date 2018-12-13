self: super:

# http://nbp.github.io/slides/NixCon/2017.NixpkgsOverlays/
# https://blog.flyingcircus.io/2017/11/07/nixos-the-dos-and-donts-of-nixpkgs-overlays/

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
    gomplate     = super.callPackage ./package/gomplate {};

    # temporary override for dep, the current version is ancient
    dep = super.callPackage ./package/godep {};

    vscode = super.callPackage ./package/vscode {};

    xeventbind = super.callPackage ./package/xeventbind {
        libX11 = super.xorg.libX11;
    };

    # https://github.com/NixOS/nixpkgs/issues/35088
    # https://blog.flyingcircus.io/2017/11/07/nixos-the-dos-and-donts-of-nixpkgs-overlays/
    vscode-with-cpp = super.vscode-with-extensions.override {
        vscodeExtensions = with self.vscode-extensions; [ ms-vscode.cpptools ];
    };

    sql-workbench = super.callPackage ./package/sql-workbench {};
}


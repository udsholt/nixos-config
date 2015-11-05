{ fetchgit, fetchurl, stdenv, which, pkgconfig, makeWrapper, libxcb, xcbutilkeysyms
, xcbutil, xcbutilwm, libstartup_notification, libX11, pcre, libev, yajl
, xcb-util-cursor, coreutils, perl, pango, perlPackages, xdummy, libxkbcommon }:

stdenv.mkDerivation rec {
  name = "airblader-${version}";
  version = "4.11";

  src = fetchurl {
    url = "https://github.com/Airblader/i3/archive/${version}.tar.gz";
    sha256 = "1kxhcsggj115y2xnw4hxcfzq2ghis2jjwgh9w2jny760dzc89h8f";
  };

  buildInputs = [
    which pkgconfig makeWrapper libxcb xcbutilkeysyms xcbutil xcbutilwm
    libstartup_notification libX11 pcre libev yajl xcb-util-cursor perl pango
    perlPackages.AnyEventI3 perlPackages.X11XCB perlPackages.IPCRun
    perlPackages.ExtUtilsPkgConfig perlPackages.TestMore perlPackages.InlineC
    libxkbcommon
  ];

  postPatch = ''
    patchShebangs .
  '';

  # Fix for git decribe:
  # * https://github.com/Airblader/i3/issues/43
  # * https://github.com/Airblader/i3/issues/26
  postUnpack = ''
    echo "${version} ($(date +"%Y-%m-%d"), branch \\\"${version}\\\")" > $sourceRoot/I3_VERSION
    echo "${version}" > $sourceRoot/VERSION
  '';

  configurePhase = ''
    makeFlags=PREFIX=$out;
  '';

  postInstall = ''
    wrapProgram "$out/bin/i3-save-tree" --prefix PERL5LIB ":" "$PERL5LIB"
  '';

  meta = with stdenv.lib; {
    description = "A tiling window manager";
    homepage    = "https://github.com/airblader/i3";
    maintainers = with maintainers; [ garbas modulistic ];
    license     = licenses.bsd3;
    platforms   = platforms.all;

    longDescription = ''
      A tiling window manager primarily targeted at advanced users and
      developers. Based on a tree as data structure, supports tiling,
      stacking, and tabbing layouts, handled dynamically, as well as
      floating windows. Configured via plain text file. Multi-monitor.
      UTF-8 clean.
    '';
  };

}

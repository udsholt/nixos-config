{ fetchgit, stdenv, which, pkgconfig, makeWrapper, libxcb, xcbutilkeysyms
, xcbutil, xcbutilwm, libstartup_notification, libX11, pcre, libev, yajl
, xcb-util-cursor, coreutils, perl, pango, perlPackages, xdummy, libxkbcommon, git }:

stdenv.mkDerivation rec {
  name = "airblader-${version}";
  version = "4.10.2";

  src = fetchgit {
    name = "i3-airblader";
    url = https://github.com/Airblader/i3.git;
    rev = "75a83a8ef08187a07aa0992b890d346c0d55466f";
    sha256 = "1wc8nlp9jkn0vpjn2rdhq1ac3ilnq9mr571az16vfl7fw8kkgcw1";
    leaveDotGit = true;
  };

  buildInputs = [
    which pkgconfig makeWrapper libxcb xcbutilkeysyms xcbutil xcbutilwm
    libstartup_notification libX11 pcre libev yajl xcb-util-cursor perl pango
    perlPackages.AnyEventI3 perlPackages.X11XCB perlPackages.IPCRun
    perlPackages.ExtUtilsPkgConfig perlPackages.TestMore perlPackages.InlineC
    libxkbcommon git
  ];

  postPatch = ''
    patchShebangs .
  '';

  # Fix for git decribe:
  # 
  #   leaveDotGit = true
  #   git tag ${version}
  #
  # * https://github.com/Airblader/i3/issues/43
  # * https://github.com/Airblader/i3/issues/26
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

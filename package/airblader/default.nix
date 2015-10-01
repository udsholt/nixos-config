{ fetchgit, stdenv, which, pkgconfig, makeWrapper, libxcb, xcbutilkeysyms
, xcbutil, xcbutilwm, libstartup_notification, libX11, pcre, libev, yajl
, xcb-util-cursor, coreutils, perl, pango, perlPackages, xdummy, libxkbcommon, git }:

stdenv.mkDerivation rec {
  name = "airblader-${version}";
  version = "4.10.4";

  src = fetchgit {
    name = "i3-airblader";
    url = https://github.com/Airblader/i3.git;
    rev = "2f1c242723de589bfc6a4c988a1d805a1eb41586";
    sha256 = "0q9vayaij6wag1v5j4yy80xgz069kpzw77sjmai0px0c37d0m8f5";
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
    git tag ${version}
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

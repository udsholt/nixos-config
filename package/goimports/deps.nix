{ stdenv, lib, fetchFromGitHub }:

let
  goDeps = [
    {
      root = "golang.org/x/tools";
      src = fetchFromGitHub {
        owner = "golang";
        repo = "tools";
        rev = "b1aed1a596ad02d2aa2eb5c5af431a7ba2f6afc4";
        sha256 = "1f20r8s63jbafx902iqj286jvb7201nwp7hlxh182i143jg87h1p";
      };
    }
  ];

in

stdenv.mkDerivation rec {
  name = "go-deps";

  buildCommand =
    lib.concatStrings
      (map (dep: ''
              mkdir -p $out/src/`dirname ${dep.root}`
              ln -s ${dep.src} $out/src/${dep.root}
            '') goDeps);
}
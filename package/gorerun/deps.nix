{ stdenv, lib, fetchFromGitHub }:

let
  goDeps = [
    {
      root = "github.com/skelterjohn/rerun";
      src = fetchFromGitHub {
        owner = "skelterjohn";
        repo = "rerun";
        rev = "e317af9469ea6d0a63244f7b985660062610237c";
        sha256 = "0kimhf1visnrv42rlr66pfxal8n7fbyj7a6v8m75vbmabs3nc9fs";
      };
    }
    {
      root = "github.com/howeyc/fsnotify";
      src = fetchFromGitHub {
        owner = "howeyc";
        repo = "fsnotify";
        rev = "4894fe7efedeeef21891033e1cce3b23b9af7ad2";
        sha256 = "09r3h200nbw8a4d3rn9wxxmgma2a8i6ssaplf3zbdc2ykizsq7mn";
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
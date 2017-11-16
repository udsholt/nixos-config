{ stdenv, lib, fetchFromGitHub }:

let
  goDeps = [
    {
      root = "golang.org/x/tools";
      src = fetchFromGitHub {
        owner = "golang";
        repo = "tools";
        rev = "6f233b96dfbc53e33b302e31b88814cf74697ff6";
        sha256 = "0zpzb1qhwg4nrgji42bzislwypql5kz4zbm0rqzxfn4vdjy0dzml";
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
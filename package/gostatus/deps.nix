{ stdenv, lib, fetchFromGitHub }:

let
  goDeps = [
    {
      root = "github.com/shurcooL/gostatus";
      src = fetchFromGitHub {
        owner = "shurcooL";
        repo = "gostatus";
        rev = "a8c20bb3932cc2eb1b5a3eb8ed9a6b1e7aa988df";
        sha256 = "1h9h291iycg8swfdm4gypkifc89xbsvnp35ggjiwmxjadl7sfwjj";
      };
    }
    {
      root = "github.com/kisielk/gotool";
      src = fetchFromGitHub {
        owner = "kisielk";
        repo = "gotool";
        rev = "d678387370a2eb9b5b0a33218bc8c9d8de15b6be";
        sha256 = "02rxryjx03h2d687ci8s50l84s6aajfk1mqydksi0rcjk4ybfrzs";
      };
    }
    {
      root = "github.com/shurcooL/go";
      src = fetchFromGitHub {
        owner = "shurcooL";
        repo = "go";
        rev = "63cf1e6a448b7f45ff62f1813dc514ebec6abb53";
        sha256 = "1pqdbjs1dqsqzv0kqxifq4l4xrajrz44ajjjc64agx8i48776v75";
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
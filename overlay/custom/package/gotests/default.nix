# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "gotests-unstable-${version}";
  version = "2017-10-23";
  rev = "3ba09dc73ae80f33b61c8a1e7f5ab3ca803d3320";

  goPackagePath = "github.com/cweill/gotests";
  excludedPackages = "testdata";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/cweill/gotests.git";
    sha256 = "18bwjrr400r7sfp63bzpxgqbdz6hnhfx2r6hh3gav9p3rwdl5p6b";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}

# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "govendor-unstable-${version}";
  version = "2017-11-17";
  rev = "2f31c31aa4cb2734ed77fda720b4bc4c63ef35ef";

  goPackagePath = "github.com/kardianos/govendor";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/kardianos/govendor.git";
    sha256 = "1aix2v2v70xrdlzka6jiy6xsx3wsy5q3zq5ji6cc85j58lj8bdp5";
  };

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}

# This file was generated by https://github.com/kamilchm/go2nix v1.2.1
{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "gomplate-unstable-${version}";
  version = "2018-02-18";
  rev = "6b3048a744d42455edbe2d9b6b2a4039c8ef8f8e";

  goPackagePath = "github.com/hairyhenderson/gomplate";

  src = fetchgit {
    inherit rev;
    url = "https://github.com/hairyhenderson/gomplate.git";
    sha256 = "0962xdkmqx3x7cfaarzg9p33kym3hx8qnf05j1n9imlh89izx19v";
  };

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
  };
}

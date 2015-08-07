# Pakcage for rtl8723au wifi driver for yoga 13.
# 
# Does not seem to play nice with wpa_supplicant, so im using wicd.
# Requires the following nixos configration:
# 
#   boot.extraModulePackages = [ pkgs.rtl8723au ]
#   boot.kernelModules = [ "8723au" ];
#
# Notes:
# ------
#
# I got kernel working by adding pkgs.linuxPackages to callpackage in all.
#
# Loading kernel modules from packages:
# * http://lists.science.uu.nl/pipermail/nix-dev/2012-October/009933.html
#
# This was the first one i found that looked promising
#  * https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/broadcom-sta/default.nix
#
# This one uses a custom builder
#  *https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nvidia-x11/default.nix
#
# This one replacement in make file (think this will work)
# * https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/e1000e/default.nix
#
{ stdenv, fetchurl, unzip, kernel }:

stdenv.mkDerivation rec {

  name = "rtl8723au-1.0.1";
  
  src = fetchurl {
    url = "https://github.com/lwfinger/rtl8723au/archive/master.zip";
    sha256 = "1k1nnn4j3b4fy2wc3impc5s50mk5wmpcb9p4rvy9i3dxv5akjxqi";
  };

  dontStrip = true;

  enableParallelBuilding = true;

  configurePhase = ''
    kernel_version=${kernel.modDirVersion}
    sed -i -e 's|/lib/modules|${kernel.dev}/lib/modules|' Makefile
    export makeFlags="KVER=$kernel_version"
  '';

  installPhase = ''
    install -v -D -m 644 8723au.ko "$out/lib/modules/$kernel_version/kernel/drivers/net/wireless/8723au.ko"
  '';

  buildInputs = [ unzip ];
}

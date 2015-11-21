{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        clang
        llvmPackages.lldb

        gnumake
        premake
        cmake
    ];
}

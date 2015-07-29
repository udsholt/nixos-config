{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        idea.clion
        qtcreator
        qt5Full

        clang
        llvmPackages.lldb

        gnumake
        premake
        cmake
    ];
}

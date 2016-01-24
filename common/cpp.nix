{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        clang
        llvmPackages.lldb

        gnumake
        premake5
        premake4

        glm
        glfw
        glew
        mesa
    ];
}

{ pkgs, config, ... }:

{
    # Import custom modules
    imports = import ../module/all.nix;

    # Import custom package overrides
    #nixpkgs.config.packageOverrides = pkgs: (import ../package {
    #    pkgs = pkgs;
    #});

    # Import custom overlays
    nixpkgs.overlays = [
        (import ../overlay/custom)
    ];

    # Required for sublime, so just include it everywhere
    # * http://fluffynukeit.com/category/nixos/
    # * https://github.com/NixOS/nixpkgs/issues/4766
    nixpkgs.config.allowUnfree = true;

    # Add handy utilities 
    environment.systemPackages = with pkgs; [
        lsof
        tree
        psmisc
        wget
        pwgen
        which
        unzip
        zip
        nox
        pciutils
        pv
        jq

        vimNox
        sshuttle

        git
        gettext # https://github.com/NixOS/nixpkgs/issues/13150
        tig
        mercurial
    ];

    # Enable zsh
    programs.zsh.enable = true;

    # Enable ssh agent
    programs.ssh.startAgent = true;
}

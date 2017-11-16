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

    # Add some basic stuff
    environment.systemPackages = with pkgs; [
        lsof
        tree
        psmisc
        wget
        which
        unzip
        zip
        nox
        pciutils
        pv
        sift
        vimNox

        git
        gettext # https://github.com/NixOS/nixpkgs/issues/13150
        tig
        mercurial
        # subversionClient
    ];

    # Enable zsh
    programs.zsh.enable = true;

    # Enable ssh agent
    programs.ssh.startAgent = true;
}

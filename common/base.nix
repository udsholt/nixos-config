# base configuration
{ pkgs, ... }:

{
    # Import custom modules
    imports = import ../module/all.nix;

    # Override configuration based on:
    # * https://github.com/aszlig/vuizvui
    nixpkgs.config.packageOverrides = import ../override;

    # TODO: consider moving this somewhere else.
    #
    # Using pdf reader in chrome.
    #
    # If the mirror containing the debian package for google-chrome-stable
    # is to slow, it can be obtained from somewhere else add preloaded into
    # the store using (note the location prefix):
    #
    # sudo nix-store --add-fixed sha256 ./google-chrome-stable_45.0.2454.85-1_amd64.deb
    #
    nixpkgs.config.chromium = {
        enablePepperPDF = true;
        enableWideVine = true;
    };

    # Required for sublime, so just include it everywhere
    # * http://fluffynukeit.com/category/nixos/
    # * https://github.com/NixOS/nixpkgs/issues/4766
    nixpkgs.config.allowUnfree = true;

    # Add some basic stuff
    environment.systemPackages = with pkgs; [
        lsof
        tree
        wget
        which
        unzip
        zip
        nox
        sshuttle
        pciutils
        python
        pv
        sift

        git
        tig
        mercurial

        sakura

        chromium
        spotify

        sublime3
        vimNox
        atom

        oxygen_gtk
        numix-gtk-theme
        numix-icon-theme
        gtk_engines
        hicolor_icon_theme
        lxappearance

        xfce.thunar
        xfce.xfce4icontheme

        pcmanfm
    ];

    # Enable zsh
    programs.zsh.enable = true;

    # Setup sakura as terminal
    environment.variables = {
        TERMINAL = "sakura";
    };

    # Basic configuration of the xserver
    services.xserver = {
        enable = true;
        displayManager.slim = {
            enable = true;
            defaultUser = "";
            theme = pkgs.fetchgit {
                url    = "https://github.com/naglis/slim-minimal.git";
                rev    = "65759e026e8de1f957889e81ca6faf3b8c2167a7";
                sha256 = "0ggkxgx5bdf3yvgfhs594v1h6nkjq6df4kfg5d51jpga0989c28y";
            };
        };
        desktopManager = {
            xterm.enable = false;
            default = "none";
        };
    };

    # Font configuration
    fonts = {
        enableCoreFonts = true;
        enableFontDir = true;
        fonts = with pkgs; [
            font-awesome
        ];
    };

    # Configuration for oxygen_gtk
    environment.shellInit = ''
        export GTK_PATH=$GTK_PATH:${pkgs.oxygen_gtk}/lib/gtk-2.0
        export GTK2_RC_FILES=$GTK2_RC_FILES:${pkgs.oxygen_gtk}/share/themes/oxygen-gtk/gtk-2.0/gtkrc
    '';
}

# Desktop configuration.
#
# Link /run/current-system/sw/share/themes to ~/.themes and use lxappearance to configure.
#
# i3 screenshots:
#
# bindsym      Print exec "maim ~/image/screenshot/$(date +%Y%m%d_%H%M%S).png"
# bindsym $mod+Print exec "maim -s ~/image/screenshot/$(date +%Y%m%d_%H%M%S).png"
#
#
# Associations:
#
#   $ xdg-mime query filetype somefile.tar.gz
#   application/x-xz
#   $ xdg-mime default xarchiver.desktop application/x-xz
#
#   or add it manually to: ~/.config/mimeapps.list
#
#   Dekstop files are stored in: /run/current-system/sw/share/applications/
{ pkgs, config, ... }:

{
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
    #    enableWideVine = true;
    };

    # Add some desktop packages
    environment.systemPackages = with pkgs; [
        pkgs.terminator
        pkgs.sakura

        pkgs.chromium
        # pkgs.firefox
        # pkgs.spotify
        pkgs.sublime3
        pkgs.neovim
        pkgs.neovim-qt

        pkgs.slack

        pkgs.maim
        pkgs.slop

        pkgs.shared_mime_info # contained the missing mime information

        pkgs.slack

        #pkgs.gtk2
        pkgs.gtk_engines
        pkgs.gtk-engine-murrine

        pkgs.numix-gtk-theme
        pkgs.numix-icon-theme
        pkgs.numix-icon-theme-circle

        pkgs.xfce.xfconf
        (
            pkgs.xfce.thunar.override {
                thunarPlugins = [
                    pkgs.xfce.thunar-archive-plugin
                    pkgs.xfce.thunar_volman
                ];
            }
        )

        pkgs.lxappearance

        pkgs.gnome3.file-roller
        pkgs.xarchiver
    ];

    # Setup sakura as terminal
    environment.variables = {
        #TERMINAL = "sakura";
        TERMINAL = "terminator";
    };

    # Redshift screen adjustment as systemd user service
    services = {
        redshift = {
            enable = true;
            latitude = "55.8";
            longitude = "12.6";
        };
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

    environment.shellInit = ''
        # Set GTK_PATH so that GTK+ can find the theme engines.
        export GTK_PATH="${config.system.path}/lib/gtk-2.0:${config.system.path}/lib/gtk-3.0"

        # Set GTK_DATA_PREFIX so that GTK+ can find themes (does not seem to work).
        export GTK_DATA_PREFIX=${config.system.path}
    '';

    environment.pathsToLink = [
        "/share/themes"
        "/share/mime"
    ];

    fonts = {
        enableCoreFonts = true;
        enableFontDir = true;
        fonts = with pkgs; [
            pkgs.font-awesome
        ];
    };
}

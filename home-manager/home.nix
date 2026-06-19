# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # ./nvim.nix
  ];

  home = {
    username = "bored";
    homeDirectory = "/home/bored";

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors; # Or whatever cursor theme you prefer (e.g., pkgs.adwaita-icon-theme)
      name = "Bibata-Modern-Classic"; # Run `ls` on the package output or use standard "Adwaita"
      size = 24;                      # Matches the standard default GNOME size
    };

    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      appindicator
      dash-to-dock
      caffeine
      clipboard-indicator
    ];
  };

  dconf = {
    enable = true;
    settings = {
      # Moved color-scheme to its correct home
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${./assets/wallpaper.png}";
        picture-uri-dark = "file://${./assets/wallpaper.png}"; # For dark mode
        picture-options = "scaled"; # Options: "none", "wall", "centered", "scaled", "stretched", "zoom", "spanned"
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${./assets/wallpaper.png}";
        picture-options = "scaled";
      };

      # Base GNOME Shell config (un-nested and using valid .extensionUuid tags)
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          appindicator.extensionUuid
          dash-to-dock.extensionUuid
          caffeine.extensionUuid
          clipboard-indicator.extensionUuid
        ];
      };

      # Individual extension profiles (all separated at the top level)
      "org/gnome/shell/extensions/dash-to-dock" = {
        extend-height = false;
        custom-theme-shrink = true;
        dock-position = "BOTTOM";
        dash-max-icon-size = 32;
      };

      "org/gnome/shell/extensions/blur-my-shell" = {
        brightness = 0.75;
        sigma = 30;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur = true;
      };

      "org/gnome/shell/extensions/caffeine" = {
        show-indicator = "always";
        show-notifications = false;
      };
    };
  };

  programs.retroarch = {
    enable = true;
    cores = {
      beetle-psx-hw = { enable = true; };
      pcsx2         = { enable = true; };
      mupen64plus   = { enable = true; };
      ppsspp        = { enable = true; };
      snes9x        = { enable = true; };
    };
  };

  programs.git = {
    enable = true;
    userName = "Vaibhav3284";       # Replace with your actual name
    userEmail = "vaibhavjatoliya1@gmail.com"; # Replace with your actual email

    # Optional but highly recommended extra configurations:
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "emacs";       # Replace with nvim, code, etc. if preferred
      pull.rebase = false;        # Standard merge behavior on pull
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}

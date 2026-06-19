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

  # Automatically symlinks your folders in ~/dots/.config/ into ~/.config/
  xdg.configFile = {
    "sway".source = ../.config/sway;
    "swayidle".source = ../.config/swayidle;
    "swaylock".source = ../.config/swaylock;
    "waybar".source = ../.config/waybar;
    "mako".source = ../.config/mako;
    "foot".source = ../.config/foot;
    "fuzzel".source = ../.config/fuzzel;
    "fish".source = ../.config/fish;
    "starship.toml".source = ../.config/starship.toml;
  };

  home = {
    username = "bored";
    homeDirectory = "/home/bored";

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    packages = with pkgs; [
      # GNOME Extensions
      gnomeExtensions.blur-my-shell
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-dock
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator

      # --- ADDED: Sway & Wayland toolchain applications ---
      swayidle
      swaylock
      waybar
      mako
      foot
      fuzzel
      fish
      starship
      protonup-ng

      # --- ADDED: RetroArch core packages ---
      libretro.beetle-psx-hw
      libretro.pcsx2
      libretro.mupen64plus
      libretro.ppsspp
      libretro.snes9x
    ];
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${./assets/wallpaper.png}";
        picture-uri-dark = "file://${./assets/wallpaper.png}";
        picture-options = "scaled";
      };

      "org/gnome/desktop/screensaver" = {
        picture-uri = "file://${./assets/wallpaper.png}";
        picture-options = "scaled";
      };

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
    # FIXED: Replaced invalid 'cores' block with proper directory paths
    settings = {
      libretro_directory = "~/.config/retroarch/cores";
      libretro_info_path = "~/.config/retroarch/cores/info";
      assets_directory = "~/.config/retroarch/assets";
      content_database_path = "~/.config/retroarch/database/rdb";
      cursor_directory = "~/.config/retroarch/database/cursors";
      cheat_database_path = "~/.config/retroarch/cheats";
    };
  };

  programs.git = {
    enable = true;
    userName = "Vaibhav3284";
    userEmail = "vaibhavjatoliya1@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "emacs";
      pull.rebase = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "26.05";
}

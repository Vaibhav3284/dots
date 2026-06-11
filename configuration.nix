{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../../etc/nixos/hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.displayManager.plasma-login-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  services.desktopManager.plasma6.enable = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nix/walls/wall1.png
    '';
  };

  users.users.bored = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      gamescope
      mangohud
      gamemode
    ];
  };


  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/bored/nix/";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";
}


{ self, inputs, ... }: {

  flake.nixosModules.myMachineConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; 
  
  networking.networkmanager.enable = true;
  
  environment.variables = {
    XCURSOR_SIZE = "24";
    XCURSOR_THEME = "Adwaita";
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "euro";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.bored = {
    isNormalUser = true;
    description = "bored";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;
  programs.steam = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    (pkgs.symlinkJoin {
      name = "neovim";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.neovim ];
    
      postBuild = ''
        wrapProgram $out/bin/nvim \
          --set XDG_CONFIG_HOME "/home/bored/dots"
      '';
    })
    (pkgs.symlinkJoin {
      name = "neovim";
      buildInputs = [ pkgs.makeWrapper ];
      paths = [ pkgs.kitty ];
    
      postBuild = ''
        wrapProgram $out/bin/kitty \
          --set XDG_CONFIG_HOME "/home/bored/dots"
      '';
    })
    wget
    grim
    heroic
    git
    stremio-linux-shell
    spotify
  
    libXcursor
    adwaita-icon-theme
    tree
    fastfetch
    clang
    fzf
  ];
  
  fonts = {
    packages = with pkgs; [
      liberation_ttf
    ];
  };


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
  
  };

}

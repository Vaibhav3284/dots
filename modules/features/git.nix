# modules/features/git.nix
{ ... }: {
  
  flake.nixosModules.myMachineConfiguration = { pkgs, ... }: {
    
    # 1. Install Git system-wide
    environment.systemPackages = [ pkgs.git ];

    # 2. Native NixOS System-wide XDG configuration
    # Placing this inside /etc/xdg means Git reads it globally as default fallback config.
    environment.etc."xdg/git/config".text = ''
      [user]
          name = Vaibhav3284
          email = your-email@example.com
      [init]
          defaultBranch = main
      [pull]
          rebase = true
      [core]
          editor = nvim
    '';

  };
}

# modules/features/kitty.nix
{ self, ... }: {
  flake.nixosModules.myMachineConfiguration = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.kitty ];

    # Pure path: Resolves directly relative to your flake repository
    environment.etc."xdg/kitty".source = "${self}/kitty";
  };
}

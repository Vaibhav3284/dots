# modules/features/neovim.nix
{ self, ... }: {
  flake.nixosModules.myMachineConfiguration = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.neovim ];

    # Pure path: self points to the root of your flake repo (~/dots)
    environment.etc."xdg/nvim".source = "${self}/nvim";

    environment.variables.EDITOR = "nvim";
  };
}

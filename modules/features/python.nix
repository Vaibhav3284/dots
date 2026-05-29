{ ... }: {
  # This tells flake-parts to inject this config block globally
  flake.nixosModules.myMachineConfiguration = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      python3
      ruff
      pyright
    ];
  };
}

# modules/features/neovim.nix
{ self, ... }: {
  flake.nixosModules.myMachineConfiguration = { pkgs, ... }: {
    
    environment.systemPackages = [
      (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (pkgs.neovimUtils.makeNeovimConfig {
        # This forces Nix to treat your entire folder as the absolute root config directory
        luaRcContent = builtins.readFile "${self}/nvim/init.lua";
        
        # This hooks up your submodules (like bored.lazy, bored.core.theme) 
        # so they are natively available in the Lua package path
        wrapperArgs = [
          "--suffix" "LUA_PATH" ";" "${self}/nvim/lua/?.lua;${self}/nvim/lua/?/init.lua"
        ];
      }))
    ];

    environment.variables.EDITOR = "nvim";
  };
}

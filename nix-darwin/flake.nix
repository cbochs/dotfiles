{
  description = "Calvin's MacBook Pro";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
          pkgs.vim
      ];

      nix.settings.experimental-features = "nix-command flakes"; # Required for flakes

      nixpkgs.hostPlatform = "aarch64-darwin";

      programs.zsh.enable = true; # Create /etc/zshrc
      programs.fish.enable = true;

      security.pam.enableSudoTouchIdAuth = true;

      services.nix-daemon.enable = true; # Auto upgrade nix package and daemon service

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 4;
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Calvins-MacBook-Pro
    darwinConfigurations."Calvins-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Calvins-MacBook-Pro".pkgs;
  };
}

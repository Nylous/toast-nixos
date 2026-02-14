{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    dotfiles = {
      url = "git+ssh://git@github/Nylous/toast-dotfiles.git";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, dotfiles }: {
    nixosConfigurations.toastwares = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        
	({ config, pkgs, ... }: {
	  systemd.tmpfiles.rules = [
	    "L+ /home/toast/.zshrc - toast users - ${dotfiles}/zshrc"
	  ];
	})
      ];
    };
  };
}

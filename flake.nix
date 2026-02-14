{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    dotfiles = {
      url = "git+file:///home/toast/Toasts/toast-dotfiles?shallow=1";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, dotfiles }: {
    nixosConfigurations.toastwares = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix

		({ config, pkgs, ... }: {
		  systemd.tmpfiles.rules = [
			"L+ /home/toast/.zshrc - - - - ${dotfiles}/zshrc"
			"z /home/toast/.zshrc - toast users - ${dotfiles}/zshrc"

			"L+ /home/toast/.config/nvim - - - - ${dotfiles}/config/nvim"
			"Z /home/toast/.config/nvim - toast users - ${dotfiles}/config/nvim"

			"L+ /home/toast/.config/alacritty - - - - ${dotfiles}/config/alacritty"
			"Z /home/toast/.config/alacritty - toast users - ${dotfiles}/config/alacritty"
		  ];
		})

      ];
    };
  };
}

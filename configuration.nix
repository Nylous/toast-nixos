{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # === User === 
  users = {
	  motd = "\n\t[=== Welcome to ToastOS ===]\n\n";
	  defaultUsersShell = pkgs.zsh;
	  users = {
		  toast = {
			  isNormalUser = true;
			  extraGroups = [ "wheel" ];
			  password = "changeme";
		  };
	  };
  };

  # === Systems ===

  # Enable the Flakes & nix command-line tool (Experimental for quite a time now)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # === Console ===
  console.keyMap = "fr";

  # === Programs ===
  programs = {
	zsh = {
		enable = true;
		enableLsColors = true;
		syntaxHighlighting.enable = true;
	};
	neovim = {
		enable = true;
		defaultEditor = true;
	};
  };

  # === Packages & Envs ===
  environment = {
	systemPackages = with pkgs; [
		git		# Used by flakes
	];

	# Set the default editor to nvim
	variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};
  };

  # === Fonts ===
  fonts.packages = [
	  pkgs.nerd-fonts.iosevka-term-slab
  ];
}

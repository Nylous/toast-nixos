{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;

  # Enable the Flakes & nix command-line tool (Experimental for quite a time now)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # === User === 
  users = {
	  motd = "\n\t[=== Welcome to ToastOS ===]\n\n";
	  defaultUserShell = pkgs.zsh;
	  users = {
		  toast = {
			  isNormalUser = true;
			  extraGroups = [ "wheel" ];
			  password = "changeme";
		  };
	  };
  };


  # === Fonts ===
  fonts.packages = [
	  pkgs.nerd-fonts.iosevka-term-slab
  ];


  # === Console ===
  console = {
	  keyMap = "fr";
	  font = "IosevkaTermSlab Nerd Font";
  };


  # === Packages & Envs ===
  environment = {
	systemPackages = with pkgs; [
		git		# Used by flakes
		alacritty
	];

	# Set the default editor to nvim
	variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};
  };


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


  # === Services ===
  services.displayManager.ly.enable = true;


  system.stateVersion = "25.11";
}

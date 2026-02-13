{ config, pkgs, ... }:

{
  # === Base and Imports === 
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];
  boot.loader.systemd-boot.enable = true;

  # === Network === 
  networking.hostName = "toastwares";
  networking.networkmanager.enable = true;

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
        	autosuggestions.enable = true;
		shellInit = "echo '\n\t[=== Welcome to ToastOS v0.1 ===]\n\n'";
	};

	neovim = {
		enable = true;
		defaultEditor = true;
	};

	niri = {
		enable = true;
		useNautilus = false;
	};
  };


  # === Services ===
  services = {
  	displayManager.ly.enable = true;
	xserver.xkb.layout = "fr";
  };


  system.stateVersion = "25.11";
}

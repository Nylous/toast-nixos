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
		firefox
	];

	# Set the default editor to nvim
	variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
		TOAST_DOTFILES="/home/toast/Toasts/toast-dotfiles";
		TOAST_NIXCONFIG="/home/toast/Toasts/toast-nixos";
	};
  };


  # === Programs ===
  programs = {
	zsh = {
		enable = true;
		enableLsColors = true;
		syntaxHighlighting.enable = true;
        	autosuggestions.enable = true;
		shellInit = "echo '\n\t\t[=== Welcome to ToastOS v0.3 ===]\n\n\tStay brave and remember\n\t\t...To <CODE> is to LIVE...\n\t\t\t...KNOWLEDGE is POWER...\n\n'";
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

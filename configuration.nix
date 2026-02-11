{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # User creation
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
  # Configured systems
  # Enable the Flakes & nix command-line tool (Experimental for quite a time now)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configured programs
  programms = {
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
  # Pre-installed packages
  environment.systemPackages = with pkgs; [
    git		# Used by flakes
  ];
  # Set the default editor to vim
  environment = {
	variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};
  };
  # Fonts
}

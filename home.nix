{ lib, pkgs, osConfig, ... }: {
  # Import all files in ./home/
  # Note: Will fail to build if non-nix files are present in ./home/
  imports = map (n: ./. + "/home/${n}") (builtins.attrNames (builtins.readDir ./home));

  home = rec {
    username = "anomalocaris";
    homeDirectory = "/home/${username}";
    packages = with pkgs; [
      neofetch
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      firefox # fallback browser
    ];

    persistence."/persist/home/${username}" = {
      allowOther = true;
      directories = [
        # Default directories I care about
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        # Other important stuff
        "Sync" # Syncthing
        "exercism" # Exercism
        "Projects" # Misc. programming
        "qmk_firmware" # QMK
        ".ssh" # SSH key
        # Caches I need to persist
        ".cache/bat" # bat cache --build
      ];
    };

    activation = {
      symlinkConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] #shell
        ''
          ln --symbolic --force --no-target-directory "/etc/nixos" ${homeDirectory}/nixos
          # chown -R ${username}:users /persist/etc/nixos
        '';
    };
    # DON'T TOUCH
    # Use system-level stateVersion
    stateVersion = osConfig.system.stateVersion;
  };

  programs.home-manager.enable = true;
}

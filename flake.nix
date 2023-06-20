{
  description = "My personal dotfiles for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    # Use nix-index without having to generate the database locally
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix User Repo
    nur.url = "github:nix-community/NUR";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Up to date Unison packages
    unison-nix = {
      url = "github:ceedubs/unison-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Patch for progress bars for cp and mv
    advcpmv = {
      url = "github:jarun/advcpmv";
      flake = false;
    };

    # Fork of zsh-bd zsh plugin
    zsh-bd = {
      url = "github:mawkler/zsh-bd";
      flake = false;
    };

    # Hooks to simplify zle widget code
    zsh-hooks = {
      url = "github:zsh-hooks/zsh-hooks";
      flake = false;
    };

    # Nyxt plugins
    nx-freestance-handler = {
      url = "github:kssytsrk/nx-freestance-handler";
      flake = false;
    };

    nx-fruit = {
      url = "github:atlas-engineer/nx-fruit";
      flake = false;
    };

    nx-kaomoji = {
      url = "github:aartaka/nx-kaomoji";
      flake = false;
    };

    nx-search-engines = {
      url = "github:aartaka/nx-search-engines";
      flake = false;
    };
  };

  outputs = inputs: rec {
    nixosConfigurations.home-pc = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./hosts/home-pc/configuration.nix
        inputs.disko.nixosModules.disko
        diskoConfigurations.home-pc
        inputs.nur.nixosModules.nur
        inputs.home-manager.nixosModules.home-manager
        inputs.impermanence.nixosModules.impermanence
        inputs.hyprland.nixosModules.default
        {
          # Home Manager
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.anomalocaris = {
              imports = [
                ./home.nix
                inputs.impermanence.nixosModules.home-manager.impermanence
                inputs.nix-index-database.hmModules.nix-index
                inputs.hyprland.homeManagerModules.default
              ];
            };
            # Inherit inputs to use zsh plugins not in nixpkgs
            extraSpecialArgs = {
              inherit inputs;
            };
          };

          # Impermanence
          environment.persistence = import
            ./persistence.nix;

          nixpkgs.overlays = [
            # cp and mv with progress bars
            # Uncomment when 9.3 patch is out
            # (final: prev: {
            #   advcpmv-coreutils = prev.coreutils.overrideAttrs (oldAttrs: {
            #     patches = (oldAttrs.patches or [ ]) ++ [ "${inputs.advcpmv}/advcpmv-0.9-${oldAttrs.version}.patch" ];
            #   });
            # })
            # Up to date Unison packages
            inputs.unison-nix.overlay
          ];

          # Enable Hyprland
          programs.hyprland.enable = true;

          nix.settings = {
            # Hyprland flake cache
            substituters = [ "https://hyprland.cachix.org" ];
            trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
          };
        }
      ];
    };
    # Expose this to use flake directly with Disko
    diskoConfigurations.home-pc = (import ./disko-config.nix {
      disk = "/dev/nvme0n1";
      memory = "32G";
    });
  };
}

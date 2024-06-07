{
  description = "nix devenvs for projs";

  #define packages to use // can also format as i.e: inputs.nixpkgs.url = "" // 
  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-23.11"; };

    devenv = { url = "github:cachix/devenv"; };

    nixpkgs-terraform = { # specific for terraform projects this can be omitted
      url = "github:stackbuilders/nixpkgs-terraform";
    };

    # the systems you want to expose are defined here i.e for only x64 use github:nix-systems/x86_64-linux // more info: https://github.com/nix-systems/nix-systems
    systems = { url = "github:nix-systems/default"; };
  };

  # recommended configs from devenv docs
  nixConfig = {
    extra-trusted-public-keys =
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, nixpkgs-terraform, systems }@inputs:
    let forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in {
      devShells = forEachSystem (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default =
            devenv.lib.mkShell { # define our default shell and reference our terraform nix file as a config basically
              inherit inputs pkgs;
              modules = [ ./terraform-dev.nix ];
            };
        });
    };
}

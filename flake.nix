{
  description = "A flake of secrets";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };
  };

  outputs = {self, ...}: let
    allSystems = [
      "aarch64-darwin"
      "aarch64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ];

    forAllSystems = f:
      self.inputs.nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import self.inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
        });
  in {
    devShells = forAllSystems ({pkgs}: {
      default = pkgs.mkShell {
        packages =
          (with pkgs; [
            git
            nixd
            micro
          ])
          ++ [
            self.inputs.agenix.packages.${pkgs.system}.default
            self.outputs.formatter.${pkgs.system}
          ];
      };
    });

    environment.variables.EDITOR = "micro";

    formatter = forAllSystems ({pkgs}: pkgs.alejandra);
  };
}

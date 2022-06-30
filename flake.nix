{
  description = "A reliable testing environment";
  inputs.nixpkgs.url = "nixpkgs/nixos-22.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            age
            bashInteractive
            bats
            binutils
            curl
            file
            gcc
            gh
            git
            gnumake
            go-tools
            go_1_18
            gopls
            gotools
            nettools
            nixpkgs-fmt
            openssl
            shellcheck
            shfmt
            sops
            terraform
            terragrunt
            wget
            yq
          ];
        };
      });
}

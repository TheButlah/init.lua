{
  description = "Developer Shell";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, fenix, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgsUnstable = nixpkgs-unstable.legacyPackages.${system};
        nvimPkg = pkgsUnstable.neovim;
        rustToolchain = fenix.packages.${system}.fromToolchainFile {
          file = ./rust-toolchain.toml;
          sha256 = "sha256-yMuSb5eQPO/bHv+Bcf/US8LVMbf/G/0MSfiPwBhiPpk=";
        };
      in
      {
        devShells.default = pkgs.mkShell
          {
            buildInputs = [
            ] ++ pkgs.lib.optional pkgs.stdenv.isDarwin [
              pkgs.libiconv
              pkgs.darwin.apple_sdk.frameworks.Security
            ];
            packages = (with pkgs;
              [
                nixpkgs-fmt
                stylua
                lua-language-server
              ]) ++ [
              nvimPkg
              rustToolchain
            ];
          };
        packages."nvim" = nvimPkg;
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}

{
  description = "Developer Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , fenix
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            ((import ./unstable-overlay.nix) { inherit nixpkgs-unstable; })
          ];

        };
        nvimPkg = pkgs.neovim;
        rustToolchain = fenix.packages.${system}.fromToolchainFile {
          file = ./rust-toolchain.toml;
          sha256 = "sha256-sqSWJDUxc+zaz1nBWMAJKTAGBuGWP25GCftIOlCEAtA=";
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
          ]
          ++ pkgs.lib.optional pkgs.stdenv.isDarwin [
            pkgs.libiconv
            pkgs.darwin.apple_sdk.frameworks.Security
          ]
          ++ pkgs.lib.optional pkgs.stdenv.isLinux [
            pkgs.openssl.dev
          ];
          packages =
            (with pkgs; [
              lua-language-server
              nixfmt-tree
              openssl.dev
              pkg-config
              stylua
            ])
            ++ [
              nvimPkg
              rustToolchain
            ];
        };
        packages."nvim" = nvimPkg;
        formatter = pkgs.nixfmt-tree;
      }
    );
}

{
  description = "Developer Shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , rust-overlay
    , flake-utils
    ,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default
            ((import ./unstable-overlay.nix) { inherit nixpkgs-unstable; })
          ];

        };
        nvimPkg = pkgs.neovim;
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
          ]
          ++ pkgs.lib.optional pkgs.stdenv.isDarwin [
            pkgs.libiconv
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
              tree-sitter
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

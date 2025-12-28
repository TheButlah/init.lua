{ nixpkgs-unstable, ... }:
final: _prev: {
  unstable = import nixpkgs-unstable {
    system = final.system;
  };
}

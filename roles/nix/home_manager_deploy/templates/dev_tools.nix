{ pkgs }:

[
  # Rust
  pkgs.clippy
  pkgs.rust-analyzer
  pkgs.cargo
  pkgs.rustc
  pkgs.rustfmt

  # Python
  pkgs.ruff
  pkgs.ty

  # Nix
  pkgs.nil
  pkgs.nixd
]

{ pkgs }:

[
  # Rust
  pkgs.clippy
  pkgs.rust-analyzer
  pkgs.cargo
  pkgs.rustc

  # Python
  pkgs.ruff
  pkgs.ty

  # Nix
  pkgs.nil
]

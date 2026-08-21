{ pkgs }:

[
  pkgs.pre-commit
  pkgs.devenv

  # Rust
  pkgs.clippy
  pkgs.rust-analyzer
  pkgs.cargo
  pkgs.rustc
  pkgs.rustfmt

  # Python
  pkgs.ruff
  pkgs.ty
  pkgs.uv

  # Nix
  # pkgs.nil
  pkgs.nixd
  pkgs.nixfmt
]

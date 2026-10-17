{ pkgs }:

[
  pkgs.pre-commit
  pkgs.devenv
  pkgs.gcc

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
  pkgs.poetry

  # Nix
  pkgs.nixd
  pkgs.nixfmt
]

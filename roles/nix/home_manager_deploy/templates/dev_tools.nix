{ pkgs }:

with pkgs;
[
  pre-commit
  devenv
  gcc

  just-lsp
  just

  # Rust
  cargo
  rustc
  clippy
  rust-analyzer
  rustfmt

  # Python
  ruff
  ty
  uv
  poetry

  # Nix
  nixd
  nixfmt
]

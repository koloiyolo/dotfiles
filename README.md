# Dotfiles

_NixOS at home._

My typical modern development setup for Python and Rust.

## Key Tools:

- `uv`: A modern Python dependency manager.
- `ruff`: A blazing-fast formatter and static analyzer for Python and more.
- `cargo`: The Rust development kit.
- `docker`: A containerization engine.
- `zsh`: A modern shell with good defaults and powerful customization options.
- `nvim`: A highly configurable and extensible text editor.
- `zed`: A lightning-fast, code editor built for modern development workflows, with seamless AI integration.
- `ollama`: For local LLM models and tweaking.

And many more Rust replacements for common Linux tools...

## Prequisites

- Fedora Linux
- `python3`
- `ansible`

```bash
sudo dnf install python3 ansible
```

## Setup Your machine

1. Set `ansible_user` variable in `inventory/setup.ini` to your current username.
2. Run ansible playbook:

```bash
ansible-playbook -i inventory/setup.ini main.yml --ask-become-pass -v
```

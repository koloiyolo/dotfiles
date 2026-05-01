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
- `python3.13`
- `uv`

```bash
uv sync

uv run ansible-galaxy collection install -r requirements.yml
```

## Setup your machine

1. Set `ansible_user` variable in `inventory/personal.ini` to your current username.
2. Run ansible playbook:

```bash
uv run ansible-playbook -i inventory/personal.ini fedora_personal_device.yml --ask-become-pass -v
```

## Setup my homelab :D

### Features

 - Automated deployment of SSH keys to the new nodes.
 - Automated deployment of my current development setup and shell configuration.
 - Maintenance playbooks for Debian and Fedora.
 - Orchestrated LGTM monitoring stack deployment.
 - Automated deployment of personal services.

### First run

We need to setup the default user first

```bash
uv run ansible-playbook -i inventory/homelab.ini debian_server_first_setup.yml -u root -e ansible_user=root  --ask-pass
```

### Run nominal maintenance playbook

```bash
uv run ansible-playbook -i inventory/homelab.ini debian_server_maintenance.yml
```

## Contributing

Before submitting your merge request, please fix all issues highlighted by:

```bash
uv sync

uv run ansible-lint *.yml
```

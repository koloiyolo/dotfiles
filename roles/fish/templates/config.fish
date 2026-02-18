if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init --cmd cd fish | source

set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

envsource ~/.env

### ALIASES
alias eza="ls"
alias cat="bat"
alias du="dust"

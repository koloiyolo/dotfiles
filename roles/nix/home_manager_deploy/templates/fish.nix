{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      {% for alias, cmd in home_manager_deploy_fish_aliases.items() %}
      "{{ alias }}" = "{{ cmd }}";
      {% endfor %}
    };

    functions = {
        envsource = ''
          touch $argv
          for line in (cat $argv | grep -v '^#')
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
          end
        '';
        __nix_shell_prefix = ''
          if set -q IN_NIX_SHELL
              set_color cyan
              printf '(nix) '
              set_color normal
          end
        '';
    };

    shellInit = ''
      if not functions -q __original_fish_prompt
          functions --copy fish_prompt __original_fish_prompt
      end

      function fish_prompt
            __nix_shell_prefix
            __original_fish_prompt
      end

      fish_add_path --path --move $HOME/.local/bin $HOME/.nix-profile/bin
      envsource ~/.env
      zoxide init --cmd cd fish | source
    '';
  };
}

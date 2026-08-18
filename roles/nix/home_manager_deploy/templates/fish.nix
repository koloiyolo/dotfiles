{ ... }:

let
  shellAliases = {
    eza = "ls";
    cat = "bat -p";
    du = "dust";
    zed = "zeditor";

    # git aliases
    g = "git";
    gst = "git status";
    gd = "git diff";
    gdc = "git diff --cached";
    gl = "git pull";
    gup = "git pull --rebase";
    gp = "git push --force-with-lease";
    "gc!" = "git commit -v --amend";
    gca = "git commit -v -a";
    "gca!" = "git commit -v -a --amend";
    gcm = "git commit -a -m";
    gc = "git checkout";
    gr = "git remote";
    grv = "git remote -v";
    grmv = "git remote rename";
    grrm = "git remote remove";
    grset = "git remote set-url";
    grup = "git remote update";
    grbi = "git rebase -i";
    grbc = "git rebase --continue";
    grba = "git rebase --abort";
    gb = "git branch";
    gba = "git branch -a";
    gcount = "git shortlog -sn";
    gcl = "git config --list";
    gcp = "git cherry-pick";
    glg = "git log --stat --max-count=10";
    glgg = "git log --graph --max-count=10";
    glgga = "git log --graph --decorate --all";
    glo = "git log --oneline";
    gss = "git status -s";
    ga = "git add";
    gm = "git merge";
    grh = "git reset HEAD";
    grhh = "git reset HEAD --hard";
    gclean = "git reset --hard; and git clean -dfx";
    gwc = "git whatchanged -p --abbrev-commit --pretty=medium";
    gg = "git gui citool";
    gga = "git gui citool --amend";
    gk = "gitk --all --branches";
    gsts = "git stash show --text";
    gsta = "git stash";
    gstp = "git stash pop";
    gstd = "git stash drop";

    # nix aliases
    "nix-develop" = "nix develop -c fish";
  };
in
{
  programs.fish = {
    enable = true;
    inherit shellAliases;

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

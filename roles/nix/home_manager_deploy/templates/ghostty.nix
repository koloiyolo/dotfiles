{ ... }:

{
  programs.ghostty = {
    enable = true;

    settings = {
      theme = "Adwaita Dark";
      shell-integration-features = [
        "ssh-env"
        "ssh-terminfo"
      ];
    };
  };
}

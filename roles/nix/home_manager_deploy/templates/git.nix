{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "{{ home_manager_deploy_git_user_name }}";
      user.email = "{{ home_manager_deploy_git_user_email }}";
      credential.helper = "store"; # TODO: Replace with libsecret
      push.autosetupremote = true;
      init.defaultbranch = "main";
    };
  };
}

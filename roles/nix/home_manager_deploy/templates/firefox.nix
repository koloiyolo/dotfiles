{ ... }: {
  programs.firefox = {
    enable = true;

    policies = {
      EncryptedMediaExtensions = {
        Enabled = true;
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "menupanel";
        };
      };
    };

    profiles."{{ ansible_user }}" = {
      isDefault = true;

      settings = {
        "browser.startup.homepage" = "https://google.com"; # ikik
        "browser.search.region" = "PL";
        "browser.shell.checkDefaultBrowser" = false;
        "media.eme.enabled" = true;
        "browser.eme.ui.enabled" = true;
      };
    };
  };
}

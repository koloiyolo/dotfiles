{ pkgs, ... }:

let
  ide_side = "left";
  ai_side = "right";
  dev_tools = import ./dev_tools.nix { inherit pkgs; };
in
{
  programs.zed-editor = {
    enable = true;

    extraPackages = dev_tools;

    extensions = [
      "nix"
      "toml"
      "rust"
      "python"
      "yaml"
      "markdown"
      "fish"
    ];

    userSettings = {
      autosave.after_delay.milliseconds = 500;

      outline_panel.dock = ide_side;
      git_panel.dock = ide_side;
      project_panel.dock = ide_side;

      tasks.enabled = true;
      toolbar.codeactions = true;

      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      languages = {
        Python.language_servers = [
          "ruff"
          "ty"
          "!basedpyright"
        ];
      };

      lsp.rust-analyzer.initialization_options.check.command = "clippy";
      lsp.nil.settings.autoArchive = true;

      # AI Settings
      agent = {
        dock = ai_side;
        sidebar_side = ai_side;

        default_model = {
          effort = "xhigh";
          enable_thinking = true;
          provider = "openai-subscribed";
          model = "gpt-5.6-luna";
        };
        tool_permissions.tools.terminal.always_allow = [
          { pattern = ''^git\s+diff(\s|$)''; }
          { pattern = ''^cargo\s+clippy(\s|$)''; }
          { pattern = ''^tree(\s|$)''; }
        ];
      };
      edit_predictions = {
        provider = "copilot";
        disabled_globs = [
          ".env"
          "config.yaml"
        ];
      };
    };
  };
}

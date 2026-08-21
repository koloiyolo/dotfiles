{ pkgs, ... }:

let
  ide_side = "left";

  nix_lsp_settings = {
    settings.nil.flake.autoArchive = true;
    settings.formatting.command = "nixfmt";
  };

  # ----- AI Settings ----- #
  ai_side = "right";

  ai_agent_settings = {
    dock = ai_side;
    sidebar_side = ai_side;
    inline_assistant_use_streaming_tools = false;
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

  ai_edit_predictions_settings = {
    provider = "copilot";
    mode = "subtle";
    disabled_globs = [
      ".env"
      "config.yaml"
    ];
  };

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
      "test-coverage-highlight-lsp"
      "xml"
      "html"
    ];

    userSettings = {
      autosave.after_delay.milliseconds = 500;
      inlay_hints.enabled = true;
      outline_panel.dock = ide_side;
      git_panel.dock = ide_side;
      project_panel.dock = ide_side;

      tasks.enabled = true;

      auto_update = false;
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      colorize_brackets = true;
      code_lens = "on";
      lsp_document_colors = "background";
      format_on_save = "on";

      languages = {
        Python.language_servers = [
          "ruff"
          "ty"
          "!basedpyright"
        ];
        Nix.language_servers = [
          "nixd"
          "!nil"
        ];
      };
      lsp = {
        rust-analyzer.initialization_options.check.command = "clippy";
        # nil = nix_lsp_settings;
        nixd = nix_lsp_settings;
        covhl.settings = {
          showHover = false;
          alpha = 0.05;
          colors.covered = "#2ecc71";
        };
      };

      agent = ai_agent_settings;
      edit_predictions = ai_edit_predictions_settings;
    };
  };
}

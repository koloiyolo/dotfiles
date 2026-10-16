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
    threads_sidebar.position = ai_side;
    inline_assistant_use_streaming_tools = false;
    default_model = {
      effort = "xhigh";
      enable_thinking = true;
      provider = "openai-subscribed";
      model = "gpt-6-luna";
    };
    tool_permissions.tools.terminal.always_allow = [
      { pattern = ''^git\s+diff(\s|$)''; }
      { pattern = ''^cargo\s+clippy(\s|$)''; }
      { pattern = ''^tree(\s|$)''; }
      { pattern = ''^grep(\s|$)''; }
      { pattern = ''^cat(\s|$)''; }
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
  home.sessionVariables = {
    LOCAL_NOTEBOOK_DEV = "1";
  };

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
      "coverage-lsp"
      "xml"
      "html"
    ];

    userSettings = {
      accessible_mode = true;
      autosave.after_delay.milliseconds = 500;
      inlay_hints.enabled = true;
      outline_panel.dock = ide_side;
      git_panel.dock = ide_side;
      project_panel.dock = ide_side;
      minimap.show = "auto";

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
        nixd = nix_lsp_settings;
        coverage-lsp.settings = {
          hit = "00dd000a";
          miss = "dd00000a";
        };
      };

      agent = ai_agent_settings;
      edit_predictions = ai_edit_predictions_settings;

      feature_flags = {
        tabular-data-preview = "on";
        notebooks = "on";
      };
    };
  };
}

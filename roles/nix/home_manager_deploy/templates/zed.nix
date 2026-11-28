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
      effort = "high";
      enable_thinking = true;
      provider = "openai-subscribed";
      model = "gpt-6-luna";
    };
    favorite_models = [
      {
        provider = "llama.cpp";
        model = "inkling-2-mini-sq-10";
        enable_thinking = false;
      }
      {
        provider = "llama.cpp";
        model = "inkling-2-mini-sq-20";
        enable_thinking = false;
      }
      {
        effort = "high";
        enable_thinking = true;
        provider = "openai-subscribed";
        model = "gpt-6-luna";
      }
    ];
    tool_permissions.tools = {
      terminal.always_allow = [
        # Git
        { pattern = ''^git\s+(diff|status|log|show|branch|rev-parse)\b''; }
        # Rust
        { pattern = ''^cargo\s+(clippy|check|test|fmt|metadata|tree)\b''; }
        # Filesystem inspection
        { pattern = ''^(tree|ls|head|tail|sort)\b''; }
        # Text inspection
        { pattern = ''^(cat|grep)\b''; }
        # File discovery
        { pattern = ''^find\s+[^;&|]*$''; }
      ];
      "mcp:mcp-server-gitlab:list_issues".default = "allow";
      "mcp:mcp-server-gitlab:my_issues".default = "allow";
      "mcp:mcp-server-gitlab:whoami".default = "allow";
      "mcp:mcp-server-gitlab:mr_discussions".default = "allow";
      "mcp:mcp-server-gitlab:list_merge_request_changed_files".default = "allow";
      "mcp:mcp-server-gitlab:create_merge_request_thread".default = "allow";
      "mcp:mcp-server-gitlab:get_merge_request_file_diff".default = "allow";
      "mcp:mcp-server-gitlab:get_file_contents".default = "allow";
      "mcp:mcp-server-gitlab:get_merge_request_diffs".default = "allow";
      "mcp:mcp-server-gitlab:get_merge_request".default = "allow";
      "mcp:mcp-server-gitlab:create_draft_note".default = "allow";
      "mcp:mcp-server-gitlab:delete_draft_note".default = "allow";
      "mcp:mcp-server-gitlab:list_merge_requests".default = "allow";
      "mcp:mcp-server-gitlab:discover_tools".default = "allow";
    };
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
      "mcp-server-github"
      "mcp-server-gitlab"
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

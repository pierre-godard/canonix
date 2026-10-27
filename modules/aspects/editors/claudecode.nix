# Claude Code configuration: LSP servers, lint-on-save hooks, statusline
{ den, ... }:
{
  den.aspects.claudecode = {
    includes = with den.aspects; [
      go
      python
      nodejs
      nix
      terraform
    ];

    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        mkLintHook =
          { extensions, command }:
          {
            matcher = "Edit|Write";
            hooks = [
              {
                type = "command";
                command = ''
                  file_path=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.file_path // .filePath // empty')
                  if [[ ${extensions} ]]; then
                    ${command}
                  fi
                '';
              }
            ];
          };
        statuslineScript = pkgs.writeShellScript "claude-statusline" ''
          #!/bin/bash
          input=$(cat)

          GREEN=$'\033[32m'
          YELLOW=$'\033[33m'
          RED=$'\033[91m'
          CYAN=$'\033[36m'
          RESET=$'\033[0m'

          IFS=$'\t' read -r MODEL DIR PCT ITOK OTOK <<< "$(echo "$input" | jq -r '[
            .model.display_name,
            .workspace.current_dir,
            ((.context_window.used_percentage // 0) | floor),
            ((.context_window.total_input_tokens // 0) | floor),
            ((.context_window.total_output_tokens // 0) | floor)
          ] | @tsv')"

          if [ "$PCT" -lt 50 ]; then BAR_COLOR="$GREEN"
          elif [ "$PCT" -lt 80 ]; then BAR_COLOR="$YELLOW"
          else BAR_COLOR="$RED"; fi

          FILLED=$((PCT / 10)); EMPTY=$((10 - FILLED))
          BAR=$(printf "%''${FILLED}s" | sed "s/ /█/g")$(printf "%''${EMPTY}s" | sed "s/ /░/g")

          echo -e "''${CYAN}🤖 ''${MODEL}''${RESET} | 📁 ''${DIR##*/} | 📥 ''${ITOK} 📤 ''${OTOK} | ''${BAR_COLOR}''${BAR}''${RESET} ''${PCT}%"
        '';
      in
      {
        home.packages = [ pkgs.sqlfluff ];

        # claude-code bundles its own alsa-lib, whose plugin dir never has pipewire's PCM plugin (separate store path)
        home.file.".asoundrc".text = ''
          pcm_type.pipewire {
            lib "${pkgs.pipewire}/lib/alsa-lib/libasound_module_pcm_pipewire.so"
          }
          ctl_type.pipewire {
            lib "${pkgs.pipewire}/lib/alsa-lib/libasound_module_ctl_pipewire.so"
          }
        '';

        programs.claude-code = {
          enable = true;

          mcpServers = { };

          lspServers = {
            go = {
              command = "gopls";
              args = [ "serve" ];
              extensionToLanguage = {
                ".go" = "go";
              };
            };
            typescript = {
              command = "typescript-language-server";
              args = [ "--stdio" ];
              extensionToLanguage = {
                ".ts" = "typescript";
                ".tsx" = "typescriptreact";
                ".js" = "javascript";
                ".jsx" = "javascriptreact";
              };
            };
            nix = {
              command = "nil";
              extensionToLanguage = {
                ".nix" = "nix";
              };
            };
            terraform = {
              command = "terraform-ls";
              args = [ "serve" ];
              extensionToLanguage = {
                ".tf" = "terraform";
                ".tfvars" = "terraform-vars";
              };
            };
          };

          settings = {
            model = "claude-opus-5-5";

            voiceEnabled = true;

            statusLine = {
              type = "command";
              command = toString statuslineScript;
              padding = 0;
            };

            hooks = {
              PreToolUse = [
                {
                  matcher = "Edit|Write";
                  hooks = [
                    {
                      type = "command";
                      command = ''
                        file_path=$(echo "$CLAUDE_TOOL_INPUT" | jq -r '.file_path // .filePath // empty')
                        if echo "$file_path" | grep -qE '(_pb2\.py|_pb2_grpc\.py|\.pb\.go)$'; then
                          echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"This is a generated protobuf file. Edit the source instead."}}'
                          exit 0
                        fi
                      '';
                    }
                  ];
                }
              ];
              Stop = [
                {
                  matcher = "";
                  hooks = [
                    {
                      type = "command";
                      command = ''echo '{"systemMessage":"Session ending. Run /retro for a retrospective."}'  '';
                    }
                  ];
                }
              ];
              Notification = [
                {
                  matcher = "";
                  hooks = [
                    {
                      type = "command";
                      command = "${pkgs.pipewire}/bin/pw-play /usr/share/sounds/freedesktop/stereo/message-new-instant.oga &";
                    }
                  ];
                }
              ];
              PostToolUse = [
                (mkLintHook {
                  extensions = ''"$file_path" == *.go'';
                  command = ''golangci-lint run --fix "$file_path" 2>/dev/null || true'';
                })
                (mkLintHook {
                  extensions = ''"$file_path" == *.py'';
                  command = ''
                    uvx ruff check --fix "$file_path" 2>/dev/null || true
                    uvx ruff format "$file_path" 2>/dev/null || true
                  '';
                })
                (mkLintHook {
                  extensions = ''"$file_path" == *.nix'';
                  command = ''nixfmt "$file_path" 2>/dev/null || true'';
                })
                (mkLintHook {
                  extensions = ''"$file_path" == *.tf'';
                  command = ''terraform fmt "$file_path" 2>/dev/null || true'';
                })
                (mkLintHook {
                  extensions = ''"$file_path" == *.js || "$file_path" == *.ts || "$file_path" == *.jsx || "$file_path" == *.tsx'';
                  command = ''npx --yes prettier --write "$file_path" 2>/dev/null || true'';
                })
                (mkLintHook {
                  extensions = ''"$file_path" == *.sql'';
                  command = ''sqlfluff fix --dialect bigquery "$file_path" 2>/dev/null || true'';
                })
              ];
            };
          };
        };
      };
  };
}

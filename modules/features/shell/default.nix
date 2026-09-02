{ den, ... }: {
  den.aspects.shell = {
    nixos = { pkgs, ... }: {
      programs.fish.enable = true;
      programs.bash.enable = true;
    };
    homeManager = { pkgs, lib, ... }: {
      home.packages = [ pkgs.nerd-fonts.fira-code ];
      programs = {
        starship = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
          presets = [ "nerd-font-symbols" "catppuccin-powerline" ];
          extraPackages = [ pkgs.jj-starship ];
          settings = {
            custom.jj = {
              format = "[[ $output ](fg:crust bg:yellow)]($style)";
              style = "bg:yellow";
              shell = [ "jj-starship" "--no-color" "--no-symbol" "--no-jj-prefix" "--no-git-prefix" ];
              when = "jj-starship detect";
            };
            git_branch.disabled = true;
            git_status.disabled = true;
            line_break.disabled = false;
            fill.symbol = " ";
            format = lib.concatStrings [
              "[ ](bg:red)"
              "$os"
              "$username"
              "[ ](bg:red)"
              "[](bg:peach fg:red)"
              "$directory"
              "[](bg:yellow fg:peach)"
              "\${custom.jj}"
              "[](fg:yellow bg:green)"
              "$c"
              "$rust"
              "$golang"
              "$nodejs"
              "$bun"
              "$php"
              "$java"
              "$kotlin"
              "$haskell"
              "$python"
              "[](fg:green bg:sapphire)"
              "$conda"
              "[](fg:sapphire bg:lavender)"
              "$time"
              "[ ](fg:lavender)"
              "$fill"
              "$cmd_duration"
              "$line_break"
              "$character"
            ];
            right_format = lib.concatStrings [ ];
          };
        };
        fish = {
          enable = true;
          generateCompletions = true;
        };
        nushell = {
          enable = true;
          shellAliases."uname -sm" = "^uname -sm";
        };
        helix = {
          enable = true;
          defaultEditor = true;
        };
        navi = {
          enable = true;
          enableFishIntegration = true;
          enableBashIntegration = true;
          settings.cheats.paths = [ ./cheatsheets ];
        };
      };
    };
  };
}

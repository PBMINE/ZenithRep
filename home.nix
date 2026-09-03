{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/.zenithrep/configs";
  homeconfigs = "${config.xdg.configHome}";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    waybar = "waybar";
    fastfetch = "fastfetch";
    kitty = "kitty";
    quickshell = "quickshell";
  };
in
{
  home.username = "pbmine";
  home.homeDirectory = "/home/pbmine";
  home.stateVersion = "26.11";
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };

    dotDir = "${homeconfigs}/zsh";
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./configs/zsh;
        file = ".p10k.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
    ];

    shellAliases = {
      jigsaw = "echo I have engineer, btw";
      znbuild = "sudo nixos-rebuild switch --flake ~/.zenithrep#nixos";
      znreplicate = "cd ~/.zenithrep";
      znupdate = "cd ~/.zenithrep && nix flake update";
      zncollect = "sudo nix-collect-garbage -d";
      znoptimize = "sudo nix-store --optimize";
    };

    initContent = lib.mkOrder 1000 ''
        printf '\n'
        figlet_text=$(figlet ZenithOS 2>/dev/null || echo "ZenithOS")
        date_text="Today it's $(date)"

        if [ -f /etc/os-release ]; then
          os_name=$(source /etc/os-release && echo "''${PRETTY_NAME}")
        else
          os_name="Linux"
        fi
        os_text="You're running $os_name"

        fortune_text=$(fortune -s 2>/dev/null || echo "")

        banner_content=$(printf '%s\n%s\n%s\n\n%s' "$figlet_text" "$date_text" "$os_text" "$fortune_text")

        term_width=$(tput cols 2>/dev/null || echo 80)
        max_len=0

        while IFS= read -r line; do
          clean_line=$(printf '%s' "$line" | sed 's/\x1b\[[0-9;]*m//g')
          (( ''${#clean_line} > max_len )) && max_len=''${#clean_line}
        done <<< "$banner_content"

        if [ "$max_len" -lt "$term_width" ]; then
          margin=$(( (term_width - max_len) / 2 ))
          left_padding=$(printf "%''${margin}s" "")
        else
          left_padding=""
        fi

        while IFS= read -r line; do
          if [ -z "$line" ]; then
            printf '\n'
          else
            printf '%s\n' "''${left_padding}''${line}"
          fi
        done <<< "$banner_content"
        printf '\n'

        zncommit() {
          cd ~/.zenithrep || return 1

          if [ "$1" = "-r" ]; then
              echo "--- Removing the last local commit (keeping file changes) ---"
              git reset --soft HEAD~1
              echo "Done. Current Git Status:"
              echo "--------------------------"
              git status
              return 0
          fi

          echo "--- Current Git Status ---"
          git status
          echo "--------------------------"

          if [ -z "$(git status --porcelain)" ]; then
              echo "Nothing to commit, working tree clean."
              return 0
          fi

          if [ "$1" != "-m" ] || [ -z "$2" ]; then
              echo "Error: A custom commit message is strictly required."
              echo "Usage: zncommit -m \"your commit message\""
              return 1
          fi

          local commit_msg="$2"

          git add .
          git commit -m "$commit_msg"

          echo -n "Do you want to push these changes? (y/N): "
          read -r response

          if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
              local current_branch
              current_branch=$(git branch --show-current)
              git push origin "$current_branch"
          else
              echo "Push skipped. Changes committed locally."
          fi
        }

    '';

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    enableCompletion = true;

  };

  home.packages = with pkgs; [
    fastfetch
    pfetch-rs
    fetch
    libresprite
    kdePackages.qtdeclarative
    kdePackages.konsole
    mission-center
    jp2a
    mcpelauncher-ui-qt
    element-desktop
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kate
    apostrophe
    kdePackages.lokalize
    btop
    vesktop
    rofi
    kitty
    networkmanager_dmenu
    rofi-bluetooth
    komikku
    bluetui
    awww
    vscode
    cmatrix
    steam
    wineWow64Packages.waylandFull
    winetricks
    swayosd
    inputs.waybar.packages.${pkgs.stdenv.hostPlatform.system}.waybar
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    })
    swaynotificationcenter
    gnome-themes-extra
    krita
    davinci-resolve-patched
    modrinth-app
    pavucontrol
    opencode
    qemu_kvm
    matugen
    flameshot
    grim
    zls
    zig
  ];

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  services.hyprpolkitagent.enable = true;

  programs.hyprlock.enable = true;

  xdg.enable = true;

  xdg.configFile = lib.mkMerge [
    (builtins.mapAttrs (name: subpath: {
      source = createSymlink "${dotfiles}/${subpath}";
      recursive = true;
    }) configs)
    {
      "zsh/.p10k.zsh".source = createSymlink "${dotfiles}/zsh/.p10k.zsh";
    }
  ];

}

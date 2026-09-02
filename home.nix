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
    };

    initContent = lib.mkOrder 1000 ''
      figlet ZenithOS
      echo "Today it's $(date)"
      echo "You're running $(source $(ls /etc/os-release) && echo $PRETTY_NAME)"
      echo ""
      fortune -s
      echo ""
      echo ""
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
    mission-center
    mcpelauncher-ui-qt
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

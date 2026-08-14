{
  config,
  pkgs,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/.zenithrep/configs";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    waybar = "waybar";
    fastfetch = "fastfetch";
    zsh = "zsh";
    kitty = "kitty";
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

    dotDir = "${dotfiles}/zsh";
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = "${dotfiles}/zsh";
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
    };

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';

    enableCompletion = true;

  };

  home.packages = with pkgs; [
    fastfetch
    fetch
  ];

  xdg.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = createSymlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

}

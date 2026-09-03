{ pkgs, ... }:

{
  home.username = "nullnormal";
  home.homeDirectory = "/home/nullnormal";
  home.stateVersion = "26.11";
  programs.zsh = {
    enable = true;
  };

  home.packages = with pkgs; [
      firefox
      aria2
      protonplus
      wineWow64Packages.waylandFull
      winetricks
      gnome-tweaks
      nwjs
      gnome-extension-manager
  ];
}

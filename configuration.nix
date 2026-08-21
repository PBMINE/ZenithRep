{
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./davinci-resolve-patched.nix
    inputs.mesa-git-nix.nixosModules.default
  ];

  nixpkgs.overlays = [ inputs.mesa-git-nix.overlays.default ];

  mesa-git = {
    enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vulkan-loader
      mesa.opencl
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_testing;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.wireless.iwd.enable = true;

  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;

  time.timeZone = "Asia/Bangkok";

  i18n.defaultLocale = "en_US.UTF-8";

  services.udisks2.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa = {
    enable = true;
    support32Bit = true;
  };
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;

  services.flatpak.enable = true;

  services.desktopManager.gnome.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;

  services.displayManager.ly.enable = true;
  #   services.displayManager.gdm.enable = true;

  #   services.getty.autologinUser = "pbmine";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    /*
      config.common = {
        default = [ "*" ];
      };
    */
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pbmine = {
    isNormalUser = true;
    home = "/home/pbmine";
    description = "Probably know me anyway!";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
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
      matugen
      flameshot
      grim
    ];
  };

  users.users.nullnormal = {
    isNormalUser = true;
    home = "/home/nullnormal";
    description = "GNOME Desktop User";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      aria2
      protonplus
      wineWow64Packages.waylandFull
      winetricks
      gnome-tweaks
      nwjs
      gnome-extension-manager
    ];
  };

  programs.xwayland.enable = true;
  programs.dconf.enable = true;
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = true;
    withUWSM = true;
  };

  programs.hyprlock.enable = true;

  services.hypridle.enable = true;

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
  };

  environment.sessionVariables = {
    EDITOR = "nano";
    HYPRCURSOR_THEME = "Adwaita";
    NIXOS_OZONE_WL = "1";
    RUSTICL_ENABLE = "radeonsi";
    RUSTICL_FEATURES = "fp64";
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  environment.systemPackages = with pkgs; [
    wget
    libnotify
    efibootmgr
    glib
    vulkan-tools
    unzip
    (python3.withPackages (python-pkgs: with python-pkgs; [ pygame ]))
    rustc
    cargo
    nil
    nixpkgs-fmt
    lua-language-server
    fortune
    figlet
    catch2
    gcc
  ];

  environment.etc."xdg/menus/applications.menu".source =
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://hyprland.cachix.org"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];

    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    trusted-users = [
      "root"
      "pbmine"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  zramSwap.enable = true;

  system.stateVersion = "26.11";

}

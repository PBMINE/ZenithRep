{ config, pkgs, ... }:

{
    home.username = "nullnormal";
    home.homeDirectory = "/home/nullnormal";
    home.stateVersion = "26.11";
    program.zsh = {
        enable = true;
        shellAliases = {
            btw = "echo I use thinkpad, btw";
        };
    };
}

{ config, pkgs, ... }

{
    home.username = "pbmine";
    home.homeDirectory = "/home/pbmine";
    home.stateVersion = "26.11";
    program.git.enable = true
    program.zsh = {
        enable = true;
        shellAliases = {
            jigsaw = "echo I have engineer, btw";
        };
    };
};

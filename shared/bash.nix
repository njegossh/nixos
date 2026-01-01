{ ... } : let
  motorola = "/run/user/1000/gvfs/mtp:host=motorola_motorola_edge_50_neo_ZY22L9Q82F/Internal\ shared\ storage";
  laptop = "/run/media/marko/3d553e7d-f851-4ec0-ad41-964f00f2a54b";
in {
  environment.variables = {
    MOTOROLA = motorola;
    LAPTOP = laptop;
  };
  programs.bash = {
    shellInit = ''
      export HISTSIZE=5000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignorespace
    '';
    promptInit = ''
      PS1="[ \w ] \$\[\033[0m\] " 
      bind 'set search-ignore-case on'
      bind 'set completion-ignore-case on'
    '';
  };
}

#Common commands
#sudo docker start vpn && docker exec -it vpn bash && docker stop vpn
#sudo du -sh *
#git reset --git reset --hard
#git log --patch --stat 
#git add . && git commit -m ""
#sudo nix flake update 
#sudo nixos-rebuild switch --upgrade --flake .#

{ config, ... } : let
  home = config.users.users.marko.home;
  work = "cd ${home}/Documents/Code/Gitea";
  berg = "cd ${home}/Documents/Code/Codeberg";
  commons = [
    "########################################"
    "################Directory###############"
    "${berg}/NixOS"     "${berg}/Boardline" "${berg}/Template"
    "${work}/Invoicing" "${work}/Expenses"  "${work}/Commons"
    "################Commands################"
    "sudo du -sh *" "diff -r"
    "sudo docker start vpn && docker exec -it vpn bash && docker stop vpn"
    "git log --patch --stat" "git diff" "git add . && git commit -m "
    "sudo nix flake update" "sudo nixos-rebuild switch --upgrade --flake .#"
  ];
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

      commons=(${builtins.concatStringsSep "\n        " (map (c: ''"${c}"'') commons)})

      _fzf_search_all() {
        local hist=$(history | sed 's/^[ ]*[0-9]*[ ]*//')
        local inputs=$(printf '%s\n' "$hist" "''${commons[@]}")
        local unique=$(echo "$inputs" | tac | awk '!seen[$0]++')

        READLINE_LINE=$(echo "$unique" | fzf --prompt="Search all > ") || return
        READLINE_POINT=''${#READLINE_LINE}
      }

      bind -x '"\C-p": _fzf_search_all'
    '';
  };
}

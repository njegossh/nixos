{ ... } : let
  commons = [
    "sudo docker start vpn && docker exec -it vpn bash && docker stop vpn"
    "sudo du -sh *"
    "git reset --hard" "git log --patch --stat" "git add . && git commit -m "
    "sudo nix flake update" "sudo nixos-rebuild switch --upgrade --flake .#"
  ];
in {
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

        READLINE_LINE=$(echo "$unique" | fzf --no-sort --exact) || return
        READLINE_POINT=''${#READLINE_LINE}
      }

      bind -x '"\C-p": _fzf_search_all'
    '';
  };
}

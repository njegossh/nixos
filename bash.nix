{ ... }:
let
  bashCommons = ''
    sudo du -sh *                                                           #Scan disk usage for current folder
    sudo nix flake update                                                   #NixOS update
    sudo docker start vpn && docker exec -it vpn bash && docker stop vpn    #Docker BarracudaVPN
    git log --patch --stat                                                  #All commits
    git diff                                                                #See uncommited changes
    sudo nixos-rebuild switch --upgrade --flake .#intel                     #NixOS rebuild Intel
  '';
in {
  programs.bash = {
    shellInit = ''
      export HISTSIZE=5000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignorespace
    '';
    promptInit = ''
      PS1="[ \w ] \$\[\033[0m\] "

      _fzf_custom_search() {
        local hist=$(history | sed 's/^[ ]*[0-9]*[ ]*//')
        local inputs=$(echo "$hist" ; echo "${bashCommons}")
        local unique=$(echo "$inputs" | awk '!seen[$0]++')
        READLINE_LINE=$(echo "$unique" | fzf --tac) || return

        READLINE_POINT=''${#READLINE_LINE}
      }

      bind -x '"\C-p": _fzf_custom_search'
    '';
  };
}

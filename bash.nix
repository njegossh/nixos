{ ... } : {
  programs.bash = {
    shellInit = ''
      export HISTSIZE=5000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignorespace
    '';
    promptInit = ''
      PS1="[ \w ] \$\[\033[0m\] "
      eval "$(fzf --bash)"
      bind -x '"\C-p": __fzf_history__'
    '';
  };
}

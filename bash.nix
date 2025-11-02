{ ... } : {
  programs.bash = {
    shellInit = ''
      export HISTSIZE=5000
      export HISTFILESIZE=10000
      export HISTCONTROL=ignorespace

      _fzf_custom_search() {
        local header_opts="--header='History (Ctrl-R) | Commands (Ctrl-B)'"
        
        ( history | sed 's/^[ ]*[0-9]*[ ]*//' ; cat "/home/marko/Documents/Sync/Quick.txt" ) | \
        FZF_DEFAULT_OPTS="$header_opts" fzf \
          --reverse --height 50% --no-sort \
          --bind "enter:replace-line"
          
      }
      bind -x '"\C-b": _fzf_custom_search'
    '';
    promptInit = ''
      PS1="[ \w ] \$\[\033[0m\] "
      eval "$(fzf --bash)"
      bind -x '"\C-p": __fzf_history__'
    '';
  };
}

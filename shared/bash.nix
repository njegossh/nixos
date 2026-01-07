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


      mount-s3() {
          if ! ip addr show wg0 > /dev/null 2>&1; then
              echo "Connect wireguard"
              return 1
          fi

          read -rs "pass1?Unesi lozinku za fajlove: " && echo
          read -rs "pass2?Unesi lozinku za imena: " && echo

          rclone --config /etc/rclone.conf mount minio-enc: ~/Documents/Hetzner \
            --vfs-cache-mode full \
            --crypt-password "$pass1" \
            --crypt-password2 "$pass2" \
            --daemon

          echo "✅ S3 Bucket je mount-ovan na ~/Documents/Hetzner"
        }
    '';
  };
}

#Common commands
#sudo docker start vpn && docker exec -it vpn bash && docker stop vpn
#df -h /
#git reset --git reset --hard
#git log --patch --stat 
#git add . && git commit -m ""


#sudo nix flake update 
#sudo nix-collect-garbage --delete-old && nix-store --gc
#sudo nixos-rebuild switch --upgrade --flake .#

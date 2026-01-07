{ pkgs, ... } : {
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
  services.gnome.core-apps.enable = false;
  environment = {
    gnome.excludePackages = [ pkgs.gnome-tour ];
    systemPackages = with pkgs; [
      nautilus neovim rclone cmus fuse
      blackbox-terminal epiphany foliate
    ];
  };
  environment.etc."rclone.conf".text = ''
    [minio-server]
    type = s3
    provider = Minio
    access_key_id = marko
    secret_access_key = sifra
    endpoint = http://10.0.0.1:5353
    region = us-east-1

    [minio-enc]
    type = crypt
    remote = minio-server:marko-documents
    filename_encryption = standard
    directory_name_encryption = true
  '';
}

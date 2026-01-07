{ pkgs, ... } : {
  environment = {
    systemPackages = with pkgs; [ rclone fuse ];
    etc."rclone.conf".text = ''
      [minio-server]
      type = s3
      provider = Minio
      access_key_id = marko
      secret_access_key = aaa-mnogo-jaka-sifra-aaa
      endpoint = http://10.0.0.1:5353
      region = us-east-1

      [minio-enc]
      type = crypt
      remote = minio-server:marko-documents
      filename_encryption = standard
      directory_name_encryption = true
      password = ""
      password2 = ""
    '';
  };
}

#Mozda mogu i samo mount minio-server i klasika folder

#mc alias set hetzner-minio http://10.0.0.1:5353 marko aaa-mnogo-jaka-sifra-aaa

#rclone --config /etc/rclone.conf mkdir minio-server:novi-bucket-ime

#rclone --config /etc/rclone.conf purge minio-server:marko-documents

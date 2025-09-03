let
  hosts = [
    "morgana"
    "nanpi"
    "jezebel"
  ];
  users = [
    "ayla_morgana"
    "ayla_nanpi"
  ];
  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in {
  "ayla/passwordHash.age".publicKeys = keys;
  "ayla/syncthing/morgana/key.age".publicKeys = keys;
  "ayla/syncthing/morgana/cert.age".publicKeys = keys;
  "ayla/syncthing/nanpi/key.age".publicKeys = keys;
  "ayla/syncthing/nanpi/cert.age".publicKeys = keys;
  "tailscale/auth.age".publicKeys = keys;
  "caddy.age".publicKeys = keys;
  "pds.age".publicKeys = keys;
  "rclone.age".publicKeys = keys;
  "restic-passwd.age".publicKeys = keys;
  "cloudflare/certificate.age".publicKeys = keys;
  "cloudflare/credentials.age".publicKeys = keys;
  "cloudflare/fail2ban.age".publicKeys = keys;
  "vaultwarden.age".publicKeys = keys;
  "gemini.age".publicKeys = keys;
  "copyparty.age".publicKeys = keys;
  "autobrr.age".publicKeys = keys;
  "ntfyAuto.age".publicKeys = keys;
  "miniflux.age".publicKeys = keys;
}

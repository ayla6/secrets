let
  hosts = [
    "morgana"
    "nanpi"
    "nanpi2"
  ];
  users = [
    "ayla_morgana"
    "ayla_nanpi"
    "ayla_nanpi2"
  ];
  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in {
  "ayla/syncthing/morgana/key.age".publicKeys = keys;
  "ayla/syncthing/morgana/cert.age".publicKeys = keys;
  "ayla/syncthing/nanpi/key.age".publicKeys = keys;
  "ayla/syncthing/nanpi/cert.age".publicKeys = keys;
  "tailscale/auth.age".publicKeys = keys;
  "tailscale/caddyAuth.age".publicKeys = keys;
  "pds.age".publicKeys = keys;
  "rclone.age".publicKeys = keys;
  "restic-passwd.age".publicKeys = keys;
  "cloudflare/certificate.age".publicKeys = keys;
  "cloudflare/credentials.age".publicKeys = keys;
}

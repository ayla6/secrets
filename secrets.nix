let
  hosts = [
    "morgana"
  ];
  users = [
    "ayla_morgana"
  ];
  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in {
  "ayla/syncthing/morgana/key.age".publicKeys = keys;
  "ayla/syncthing/morgana/cert.age".publicKeys = keys;
  "tailscale/auth.age".publicKeys = keys;
  "tailscale/caddyAuth.age".publicKeys = keys;
}

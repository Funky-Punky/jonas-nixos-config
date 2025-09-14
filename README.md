# jonas-nixos-config

## Usage

1. Install NixOs like you usually would
2. Make sure that /etc/nixos/hardware-configuration.nix exists
3. Delete /etc/nixos/configuration.nix - it can cause problems if you are stupid like me
4. clone this repo.
5. run sudo nixos-rebuild switch --flake <path/to/this/repo>/nixos
6. Hint: Have a look at home.nix - programs.bash.shellAliases."nrs"
7. enjoy

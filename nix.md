#

```sh
curl -L https://nixos.org/nix/install | sh
. /home/franklin/.nix-profile/etc/profile.d/nix.sh
unset NIX_REMOTE || set -e NIX_REMOTE
python3 -m pip install -r python/requirements.txt
```

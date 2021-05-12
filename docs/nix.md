# Nix Shell build env

## Linux Dev Environment Setup

Set up nix env in BASH:

```sh
curl -L https://nixos.org/nix/install | sh
. /home/franklin/.nix-profile/etc/profile.d/nix.sh
nix-shell -I nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
``

Set up the nix env in my fish shell:

```sh
set -x NIX_PATH (echo $NIX_PATH:)nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
```

Now start nix shell

```sh
unset NIX_REMOTE || set -e NIX_REMOTE
nix-shell
python -m pip install -rpython/requirements.txt
for my_x in `ls book/dot|cut -f1 -d'.'|uniq`; do dot -Txdot book/dot/${my_x}.dot | dot2tex --figonly > book/dot/${my_x}.tex;done
#/usr/bin/texstudio &
pdflatex --shell-escape -synctex=1 -interaction=nonstopmode book/devsecops_tactical.tex
exit
nix-collect-garbage -d
```

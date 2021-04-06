# Python 

Testing out nix & python build env. 
* https://github.com/dnadales/nix-latex-template

Set up the nix env in my fish shell:

```sh
set -x NIX_PATH (echo $NIX_PATH:)nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
nix-shell
python -m pip install -rrequirements.txt
cd ../book
for my_x in `ls dot|cut -f1 -d'.'|uniq`; do dot -Txdot ${my_x}.dot | dot2tex --figonly > dot/${my_x}.tex;done
#/usr/bin/texstudio &
pdflatex --shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex
exit
nix-collect-garbage -d
```


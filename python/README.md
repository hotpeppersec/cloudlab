# Python 

Testing out nix & python build env. 

```bash
nix-shell
python -m pip install -rrequirements.txt
cd ../book
#/usr/bin/texstudio &
pdflatex --shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex
exit
nix-collect-garbage -d
```
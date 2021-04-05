# Python 

Testing out nix & python build env. 
* https://github.com/dnadales/nix-latex-template

```bash
nix-shell
python -m pip install -rrequirements.txt
cd ../book
for my_x in `ls book/dot|cut -f1 -d'.'|uniq`; do dot -Txdot dot/${my_x}.dot | dot2tex --figonly > dot/my_x.tex;done
#/usr/bin/texstudio &
pdflatex --shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex
exit
nix-collect-garbage -d
```

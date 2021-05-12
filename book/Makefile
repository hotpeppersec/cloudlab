.PHONY: code dot

book: dot 
	@if [ ! -d /nix ]; then  echo "***> Where is your nix installation? <***" && exit 1; fi
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex

dot:
	for myfile in $(shell ls dot/*.dot |cut -f1 -d'.'|uniq); do dot -Txdot $$myfile.dot | dot2tex --figonly > $$myfile.tex;done

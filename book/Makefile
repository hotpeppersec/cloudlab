.PHONY: code dot

book:
	@if [ ! -d /nix ]; then  echo "***> Where is your nix installation? <***" && exit 1; fi
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode devsecops_tactical
	makeindex devsecops_tactical
	bibtex devsecops_tactical

dot:
	for myfile in $(shell ls dot/*.dot |cut -f1 -d'.'|uniq); do dot -Txdot $$myfile.dot | $(shell which dot2tex) --figonly > $$myfile.tex;done

publish:
	@pdflatex -shell-escape -synctex=1 -interaction=nonstopmode publish
	@[ -f publish.pdf ] && mv publish.pdf ../devsecops_tactical_book.pdf

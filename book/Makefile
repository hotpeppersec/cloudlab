.PHONY: code dot

book:
	@if [ ! -d /nix ]; then  echo "***> Where is your nix installation? <***" && exit 1; fi
	latexmk -pdf -synctex=1 -shell-escape devsecops_tactical
	bibtex devsecops_tactical
	latexmk -pdf -synctex=1 -shell-escape devsecops_tactical
	makeindex devsecops_tactical

clean:
	@for trash in *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f "$$trash" ]; then \
			rm -rf $$trash ; \
			rm frontmatter/$$trash ; \
			rm mainmatter/$$trash ; \
			rm backmatter/$$trash ; \
		fi ; \
	done

dot:
	for myfile in $(shell ls dot/*.dot |cut -f1 -d'.'|uniq); do dot -Txdot $$myfile.dot | $(shell which dot2tex) --figonly > $$myfile.tex;done

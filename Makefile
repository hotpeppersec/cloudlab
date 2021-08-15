.PHONY: dot python tests

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
  match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
  if match:
    target, help = match.groups()
    print("%-20s %s" % (target, help))
endef

export PRINT_HELP_PYSCRIPT

help:
	@python3 -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

book: dot ## Build the PDF file of the book
	@if [ ! -d /nix ]; then  echo "***> Where is your nix installation? <***" && exit 1; fi
	cd book && latexmk -pdf -synctex=1 -shell-escape devsecops_tactical
	cd book && bibtex devsecops_tactical
	cd book && makeindex devsecops_tactical
	cd book && latexmk -pdf -synctex=1 -shell-escape devsecops_tactical

clean: ## Clean up your mess
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f "book/$$trash" ]; then \
			rm -rf book/$$trash ; \
			rm book/frontmatter/$$trash ; \
			rm book/mainmatter/$$trash ; \
			rm book/backmatter/$$trash ; \
		fi ; \
	done

dot: ## generate Tex from dot files
	for myfile in $(shell ls book/dot/*.dot |cut -f1 -d'.'|uniq); do dot -Txdot $$myfile.dot | $(shell which dot2tex) --figonly > $$myfile.tex;done

python:  ## Build in python virtualenv
	python3 -m venv _build
	. ./_build/bin/activate
	python3 -m pip install -rrequirements.txt
	cd book && make


.PHONY: code dot

# Used for colorizing output of echo messages
BLUE := "\\033[1\;36m"
NC := "\\033[0m" # No color/default

PROJECT_DIR := book
REQS := python/requirements.txt

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

book: dot ## Generate LaTeX book in PDF
	@if [ ! -d /nix ]; then $(MAKE) print-status MSG="***> Where is your nix installation? <***" && exit 1; fi
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex

clean: ## Cleanup all the things
	@$(MAKE) print-status MSG="Clean up stale build artifacts"
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in _build *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f $$trash ] || [ -d $$trash ]; then \
					rm -rf $$trash ; \
		fi ; \
	done
	rm frontmatter/*.aux mainmatter/*.aux backmatter/*.aux

dot: ## Generate dot files
	@$(MAKE) print-status MSG="Generate dot files"
	for myfile in $(shell ls dot/*.dot |cut -f1 -d'.'|uniq); do dot -Txdot $$myfile.dot | dot2tex --figonly > $$myfile.tex;done

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

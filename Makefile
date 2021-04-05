.PHONY: book docker proposal python

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

book: ## Generate LaTeX book in PDF
	@if [ ! -d /nix ]; then $(MAKE) print-status MSG="***> Where is your nix installation? <***" && exit 1; fi
	cd $(PROJECT_DIR)
	for my_x in `ls book/dot|cut -f1 -d'.'|uniq`; do dot -Txdot dot/$(my_x).dot | dot2tex --figonly > dot/$(my_x).tex;done
	pdflatex -shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex

clean: ## Cleanup all the things
	rm book/*.aux book/*.bbl book/*.blg book/*.lof book/*.log book/*.lot book/*.out book/*.pdf book/*.synctex.gz book/*.toc
	rm book/frontmatter/*.aux mainmatter/*.aux backmatter/*.aux

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

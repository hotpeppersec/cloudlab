.PHONY: book docker proposal python

# Used for colorizing output of echo messages
BLUE := "\\033[1\;36m"
NC := "\\033[0m" # No color/default

PROJECT_DIR := /project/book
REQS := /project/python/requirements.txt
REQS_TEST := /project/python/requirements-test.txt
SPHINX_DIR := /project/docs

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

book: python ## Generate LaTeX book in PDF
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make book inside docker container <***" && exit 1; fi
	chown -R 1000:1000 $(PROJECT_DIR)
	dot -Txdot $(PROJECT_DIR)/dot/docker.dot | dot2tex --figonly > $(PROJECT_DIR)/dot/docker.tex
	dot -Txdot $(PROJECT_DIR)/dot/forking.dot | dot2tex --figonly > $(PROJECT_DIR)/dot/forking.tex
	dot -Txdot $(PROJECT_DIR)/dot/githubdirectory.dot | dot2tex --figonly > $(PROJECT_DIR)/dot/githubdirectory.tex
	dot -Txdot $(PROJECT_DIR)/dot/pythondirectory.dot | dot2tex --figonly > $(PROJECT_DIR)/dot/pythondirectory.tex
	dot -Txdot $(PROJECT_DIR)/dot/makefile.dot | dot2tex --figonly > $(PROJECT_DIR)/dot/makefile.tex
	cd $(PROJECT_DIR) && pdflatex -shell-escape -synctex=1 -interaction=nonstopmode devsecops_quickstart.tex
	chown -R 1000:1000 $(PROJECT_DIR)
	#cd $(PROJECT_DIR) && bibtex devsecops_quickstart.aux


clean: ## Cleanup all the things
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf
	cd $(SPHINX_DIR) && $(MAKE) clean && cd -
	cd proposal && $(MAKE) clean && cd -
	rm book/*.aux book/*.bbl book/*.blg book/*.lof book/*.log book/*.lot book/*.out book/*.pdf book/*.synctex.gz book/*.toc
	rm book/frontmatter/*.aux mainmatter/*.aux backmatter/*.aux

docker: ## build docker container for testing
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Don't run make docker inside docker container <***" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build devsecops
	@docker-compose -f docker/docker-compose.yml run devsecops /bin/bash

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

proposal: python ## build the book proposal document
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make proposal inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Building HTML book proposal"
	cd proposal && $(MAKE) html && cd -
	$(MAKE) print-status MSG="Building LaTeX book proposal"
	cd proposal && $(MAKE) latexpdf && cd -

python: ## setup python3
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make python inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python3 -m pip install -r$(REQS); fi

sphinx: python ## Generate documentation
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make sphinx inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Building HTML"
	cd docs && $(MAKE) html && cd -
	$(MAKE) print-status MSG="Building LaTeX"
	cd $(SPHINX_DIR) && $(MAKE) latexpdf && cd -
	$(MAKE) print-status MSG="Building xeLaTeX"
	cd $(SPHINX_DIR) && \
	sphinx-build -b latex -d $(SPHINX_DIR)/_build/doctrees . $(SPHINX_DIR)/_build/xetex && \
	cd $(SPHINX_DIR)/_build/xetex; xelatex *.tex
	$(MAKE) print-status MSG="Building EPUB"
	cd $(SPHINX_DIR) && make epub && cd -

test: python ## test all the things
	if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make test inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the test harness"
	if [ -f '$(REQS_TEST)' ]; then pip3 install -r$(REQS_TEST); fi

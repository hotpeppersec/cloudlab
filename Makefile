.PHONY: docker docs proposal python

# Used for colorizing output of echo messages
BLUE := "\\033[1\;36m"
NC := "\\033[0m" # No color/default

REQS := python/requirements.txt
REQS_TEST := python/requirements-test.txt

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
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

clean: ## Cleanup all the things
	find . -name '*.pyc' | xargs rm -rf
	find . -name '__pycache__' | xargs rm -rf
	cd docs && make clean && cd -
	cd proposal && make clean && cd -

docker: python ## build docker container for testing
	$(MAKE) print-status MSG="Building with docker-compose"
	@if [ -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Don't run make docker inside docker container <***" && exit 1; fi
	docker-compose -f docker/docker-compose.yml build devsecops
	@docker-compose -f docker/docker-compose.yml run devsecops /bin/bash

docs: python ## Generate documentation
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make docs inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Building HTML"
	cd docs && make html && cd -
	$(MAKE) print-status MSG="Building LaTeX"
	cd docs && make latexpdf && cd -
	$(MAKE) print-status MSG="Building xeLaTeX"
	cd docs && \
	sphinx-build -b latex -d _build/doctrees . _build/xetex && \
	cd _build/xetex; xelatex *.tex && \
	cd /book
	$(MAKE) print-status MSG="Building EPUB"
	cd docs && make epub && cd -

print-status:
	@:$(call check_defined, MSG, Message to print)
	@echo "$(BLUE)$(MSG)$(NC)"

proposal: python ## build the book proposal document
	@if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="***> Run make proposal inside docker container <***" && exit 1; fi
	$(MAKE) print-status MSG="Building HTML docs"
	cd proposal && make html && cd -
	$(MAKE) print-status MSG="Building LaTeX docs"
	cd proposal && make latexpdf && cd -

python: ## setup python3
	$(MAKE) print-status MSG="Set up the Python environment"
	if [ -f '$(REQS)' ]; then python3 -m pip install -r$(REQS); fi

test: python ## test all the things
	if [ ! -f /.dockerenv ]; then $(MAKE) print-status MSG="Run make test inside docker container" && exit 1; fi
	$(MAKE) print-status MSG="Set up the test harness"
	if [ -f '$(REQS_TEST)' ]; then pip3 install -r$(REQS_TEST); fi

clean: 
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in _build *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f $$trash ] || [ -d $$trash ]; then \
					rm -rf $$trash ; \
		fi ; \
	done
	rm frontmatter/*.aux mainmatter/*.aux backmatter/*.aux

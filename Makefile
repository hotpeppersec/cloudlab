clean: 
	@find . -name '*.pyc' | xargs rm -rf
	@find . -name '__pycache__' | xargs rm -rf
	@for trash in *.aux *.bbl *.blg *.lof *.log *.lot *.out *.pdf *.synctex.gz *.toc ; do \
		if [ -f book/$$trash ] || [ -d book/$$trash ]; then \
					rm -rf book/$$trash ; \
		fi ; \
	done
	rm book/frontmatter/*.aux book/mainmatter/*.aux book/backmatter/*.aux

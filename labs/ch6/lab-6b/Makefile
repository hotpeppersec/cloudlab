TKN := $(shell command -v tkn 2> /dev/null)

clean: 
ifndef TKN
    $(error "tkn is not available please install tekton cli")
endif
	@kubectl delete pods 
		--field-selector status.phase=Failed --all-namespaces
	@tkn pr delete --all -f
	@tkn tr delete --all -f


manifest:
	for F in $$(find * -name '*.ebuild'); do \
	    ( cd $$(dirname $$F) && \
	      ebuild $$(basename $$F) manifest; ); \
	done

.PHONY: manifest


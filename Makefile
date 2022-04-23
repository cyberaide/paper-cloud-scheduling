FILE=laszewski-cloud-scheduling

all:
	make -f Makefile copy
	make -f Makefile latex
	make -f Makefile clean
	make -f Makefile archive

clean:
	rm -f arxiv/*.aux
	rm -f arxiv/*.log
	rm -f arxiv/*.out
	rm -f arxiv/*.blg
	rm -f arxiv/${FILE}.pdf

view:
	gopen ${FILE}.pdf

latex: 
	cd arxiv; pdflatex ${FILE}
	cd arxiv; bibtex ${FILE}
	cd arxiv; pdflatex ${FILE}
	cd arxiv; pdflatex ${FILE}
	cp arxiv/${FILE}.pdf ${FILE}.pdf

copy:
	rm -rf arxiv
	mkdir -p arxiv/images
	cp ${FILE}.tex arxiv
	cp graph-*.tex arxiv
	cp table-*.tex arxiv
	cp abstract.tex arxiv
	cp content.tex arxiv
	cp frontpage-acm.tex arxiv
	cp *.bib arxiv


archive:
	rm -f arxiv.tar.gz 
	cd arxiv; tar cvfz ../arxiv.tar.gz *
	@echo "==================================="
	tar tvf arxiv.tar.gz
	@echo "==================================="


# include this in ~/.latexmkrc
# $pdf_previewer = "open -a Skim"

FILENAME=laszewski-cloud-scheduling
DIR=paper-cloud-scheduling

.PHONY: $(FILENAME).pdf watch clean

.PRECIOUS: %.pdf

all: $(FILENAME).pdf

# MAIN LATEXMK RULE

$(FILENAME).pdf: $(FILENAME).tex
	latexmk -quiet -bibtex $(PREVIEW_CONTINUOUSLY) -f -pdf -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make $(FILENAME).tex

watch: PREVIEW_CONTINUOUSLY=-pvc

watch: $(FILENAME).pdf

view:
	open -a Skim $(FILENAME).pdf

simple:
	pdflatex $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex $(FILENAME).tex
	pdflatex $(FILENAME).tex
	open -a Skim $(FILENAME).pdf

all:
	make simple
	-qpdf $(FILENAME).pdf --rotate=90:22-36 --replace-input
	make review

review:
	pdflatex review.tex
	pdflatex review.tex
	open -a Skim review.pdf

t:
	make -f Makefile table
	make -f Makefile table

table:	
	-rm $(FILENAME).pdf
	-make -f Makefile $(FILENAME).pdf
	-qpdf $(FILENAME).pdf --rotate=90:22-36 --replace-input
	# open -a Skim $(FILENAME).pdf


clean:
	rm -rf $(FILENAME).spl
	rm -f *_bibertool.bib
	rm -f *.ttt
	rm -rf *.prv
	rm -f *.blg *.out *.spl *-orig
	rm -f *.aux *.log
	# latexmk -C -bibtex


regular:
	pdflatex $(FILENAME)
	bibtex $(FILENAME)
	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

biber:
	@echo
	biber -V --tool cloud-scheduling.bib | fgrep -v INFO
	@echo
	biber -V --tool cloud-scheduling_bibertool.bib | fgrep -v INFO
	@echo
	biber -V --tool strings.bib | fgrep -v INFO
	@echo
	biber -V --tool vonlaszewski.bib | fgrep -v INFO
	@make -f Makefile clean

zip: clean
	cd ..; zip -x "*/.DS*" "*/*.git*" "*/*bin*" "*/*zip" "*/*.md" "*/Makefile" -r $(DIR)/$(FILENAME).zip $(DIR)

flatzip: clean
	zip -x "*.git*" "*bin*" "*zip" "*.md" "Makefile" -r $(FILENAME).zip .


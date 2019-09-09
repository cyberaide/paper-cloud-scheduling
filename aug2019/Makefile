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


clean:
	latexmk -C -bibtex
	rm -rf $(FILENAME).spl
	rm -f *_bibertool.bib
	rm -f *.ttt
	rm -f *.blg


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


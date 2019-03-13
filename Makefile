FILENAME=laszewski-cloud-scheduling
DIR=paper-cloud-scheduling

all: $(FILENAME).pdf

# MAIN LATEXMK RULE

$(FILENAME).pdf: $(FILENAME).tex
	latexmk -quiet -bibtex $(PREVIEW_CONTINUOUSLY) -f -pdf -pdflatex="pdflatex -synctex=1 -interaction=nonstopmode" -use-make $(FILENAME).tex


.PHONY: watch

watch: PREVIEW_CONTINUOUSLY=-pvc
watch: $(FILENAME).pdf

.PHONY: clean

clean:
	latexmk -C -bibtex
	rm -rf $(FILENAME).spl

regular:
	pdflatex $(FILENAME)
	bibtex $(FILENAME)
	pdflatex $(FILENAME)
	pdflatex $(FILENAME)


zip: clean
	cd ..; zip -x "*/.DS*" "*/*.git*" "*/*bin*" "*/*zip" "*/*.md" "*/Makefile" -r $(DIR)/$(FILENAME).zip $(DIR)

flatzip: clean
	zip -x "*.git*" "*bin*" "*zip" "*.md" "Makefile" -r $(FILENAME).zip .


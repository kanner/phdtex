ifndef template
# path to template itself
template += ./
endif
# this variable is used in Makefile[.bat], dissertation.tex,
# synopsis.tex and contrib/styles.tex (bibliographystyle)

TEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
NOMENCL=makeindex
BIBTEXHELPER = $(template)/contrib/bbl-sorter.pl

document = $(template)/dissertation
document-bib = dissertation
synopsis = $(template)/synopsis
synopsis-bib = synopsis
booklet = $(template)/booklet

COMMON += \
	$(template)/contrib/names.tex \
	$(template)/contrib/packages.tex \
	$(template)/contrib/styles.tex \
	$(template)/contrib/stylesgost.tex \
	$(template)/contrib/tweaklist.sty \
	$(template)/contrib/utf8gost71my.bst \
	00-info.tex

PARTS += \
	$(COMMON) \
	$(template)/contrib/contents.tex \
	parts/appendix.tex \
	parts/biblio.bib \
	parts/biblio-pub.bib \
	parts/biblio-vak.bib \
	$(template)/parts/intro.tex \
	$(template)/parts/lists.tex \
	$(template)/parts/references.tex \
	$(template)/01-title.tex \
	02-introduction.tex \
	03-part1.tex \
	04-part2.tex \
	05-part3.tex \
	06-part4.tex \
	07-conclusion.tex

PARTS_SYNOPSIS += \
	$(COMMON) \
	parts/biblio-pub-sheet.bib \
	parts/biblio-scopus-sheet.bib \
	parts/biblio-vak-sheet.bib \
	parts/intro-syn.tex \
	synopsis-parts/synopsis-content.tex \
	$(template)/synopsis-parts/synopsis-references.tex \
	synopsis-parts/synopsis-results.tex \
	$(template)/synopsis-parts/synopsis-title.tex \
	02-introduction.tex

all: $(document) $(synopsis) $(booklet)

$(document): $(document).tex $(PARTS)
	$(PDFLATEX) $(document).tex
	$(BIBTEX) $(document-bib)
	$(BIBTEXHELPER)
	$(NOMENCL) $(document-bib).nlo -s nomencl.ist -o $(document-bib).nls
	$(PDFLATEX) $(document).tex
	# some elements (bib, nom) could not be build
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex

$(synopsis): $(synopsis).tex $(PARTS_SYNOPSIS)
	$(PDFLATEX) $(synopsis).tex
	$(BIBTEX) $(synopsis-bib)1
	$(BIBTEX) $(synopsis-bib)2
	$(BIBTEX) $(synopsis-bib)3
	$(PDFLATEX) $(synopsis).tex
	# some elements (bib) could not be build
	$(PDFLATEX) $(synopsis).tex

$(booklet): $(synopsis) $(booklet).tex
	$(PDFLATEX) $(booklet).tex

spell: $(document).tex $(synopsis).tex $(PARTS) $(PARTS_SYNOPSIS)
	aspell --lang=ru_RU -t -c $(document).tex
	aspell --lang=ru_RU -t -c $(synopsis).tex
	for i in ${PARTS}; do \
		aspell --lang=ru_RU -t -c $${i}; \
	done
	for i in ${PARTS_SYNOPSIS}; do \
		aspell --lang=ru_RU -t -c $${i}; \
	done

# spellcheck target for template
spelltmpl: $(document).tex $(synopsis).tex $(PARTS) $(PARTS_SYNOPSIS)
	aspell --lang=ru_RU -t -c $(document).tex
	aspell --lang=ru_RU -t -c $(synopsis).tex
	for i in ${PARTS}; do \
		if [[ $${i} == $(template)* ]]; then \
			aspell --lang=ru_RU -t -c $${i}; \
		fi \
	done
	for i in ${PARTS_SYNOPSIS}; do \
		if [[ $${i} == $(template)* ]]; then \
			aspell --lang=ru_RU -t -c $${i}; \
		fi \
	done

# spellcheck target for local data
spelldata: $(PARTS) $(PARTS_SYNOPSIS)
	for i in ${PARTS}; do \
		if [[ $${i} != $(template)* ]]; then \
			aspell --lang=ru_RU -t -c $${i}; \
		fi \
	done
	for i in ${PARTS_SYNOPSIS}; do \
		if [[ $${i} != $(template)* ]]; then \
			aspell --lang=ru_RU -t -c $${i}; \
		fi \
	done

clean:
	rm -f *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
	rm -f $(template)/contrib/*.aux
	rm -f parts/*.aux parts/*.bbl parts/*.blg
	rm -f synopsis-parts/*.aux synopsis-parts/*.bbl synopsis-parts/*.blg

TEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
NOMENCL=makeindex
BIBTEXHELPER = ./contrib/bbl-sorter.pl

document = dissertation
synopsis = synopsis
booklet = booklet

PARTS = \
	contrib/contents.tex \
	contrib/names.tex \
	contrib/packages.tex \
	contrib/styles.tex \
	contrib/stylesgost.tex \
	contrib/tweaklist.sty \
	contrib/utf8gost705my.bst \
	contrib/utf8gost705u.bst \
	contrib/utf8gost71my.bst \
	contrib/utf8gost71s.bst \
	parts/appendix.tex \
	parts/biblio.bib \
	parts/biblio-pub.bib \
	parts/biblio-vak.bib \
	parts/intro.tex \
	parts/lists.tex \
	parts/references.tex \
	01-title.tex \
	02-introduction.tex \
	03-part1.tex \
	04-part2.tex \
	05-part3.tex \
	06-part4.tex \
	07-conclusion.tex

PARTS_SYNOPSIS = \
	contrib/names.tex \
	contrib/packages.tex \
	contrib/styles.tex \
	contrib/stylesgost.tex \
	contrib/tweaklist.sty \
	contrib/utf8gost705my.bst \
	contrib/utf8gost705u.bst \
	contrib/utf8gost71my.bst \
	contrib/utf8gost71s.bst \
	parts/biblio-pub-sheet.bib \
	parts/biblio-scopus-sheet.bib \
	parts/biblio-vak-sheet.bib \
	parts/intro-syn.tex \
	synopsis-parts/synopsis-content.tex \
	synopsis-parts/synopsis-references.tex \
	synopsis-parts/synopsis-results.tex \
	synopsis-parts/synopsis-title.tex \
	02-introduction.tex

all: $(document) $(synopsis) $(booklet)

$(document): $(document).tex $(PARTS)
	$(PDFLATEX) $(document).tex
	$(BIBTEX) $(document)
	$(BIBTEXHELPER)
	$(NOMENCL) $(document).nlo -s nomencl.ist -o $(document).nls
	$(PDFLATEX) $(document).tex
	# some elements (bib, nom) could not be build
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex

$(synopsis): $(synopsis).tex $(PARTS_SYNOPSIS)
	$(PDFLATEX) $(synopsis).tex
	$(BIBTEX) $(synopsis)1
	$(BIBTEX) $(synopsis)2
	$(BIBTEX) $(synopsis)3
	$(PDFLATEX) $(synopsis).tex
	# some elements (bib) could not be build
	$(PDFLATEX) $(synopsis).tex

$(booklet): $(booklet).tex
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

clean:
	rm -f *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
	rm -f contrib/*.aux
	rm -f parts/*.aux parts/*.bbl parts/*.blg
	rm -f synopsis-parts/*.aux synopsis-parts/*.bbl synopsis-parts/*.blg

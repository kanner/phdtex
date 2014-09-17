TEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
NOMENCL=makeindex

document = dissertation
PARTS = contrib/contents.tex \
		contrib/names.tex \
		contrib/packages.tex \
		contrib/stylesgost.tex \
		contrib/styles.tex \
		parts/appendix.tex \
		parts/biblio.bib \
		parts/lists.tex \
		parts/references.tex \
		01-title.tex \
		02-introduction.tex \
		03-part1.tex \
		04-part2.tex \
		05-part3.tex \
		06-conclusion.tex

all: $(document).pdf

$(document).pdf: $(document).tex $(PARTS)
	$(PDFLATEX) $(document).tex
	$(BIBTEX) $(document)
	$(NOMENCL) $(document).nlo -s nomencl.ist -o $(document).nls
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex

clean:
	rm -f *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
	rm -f contrib/*.aux parts/*.aux

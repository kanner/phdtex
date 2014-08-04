TEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex

document = dissertation
PARTS =

all: $(document).pdf

$(document).pdf: $(document).tex $(PARTS)
	$(PDFLATEX) $(document).tex
	$(BIBTEX) $(document)
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex

clean:
	rm -f *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl

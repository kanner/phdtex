TEX=latex
PDFLATEX=pdflatex
BIBTEX=bibtex
NOMENCL=makeindex

document = dissertation
PARTS =

all: $(document).pdf

$(document).pdf: $(document).tex $(PARTS)
	$(PDFLATEX) $(document).tex
	$(BIBTEX) $(document)
	$(NOMENCL) $(document).nlo -s nomencl.ist -o $(document).nls
	$(PDFLATEX) $(document).tex
	$(PDFLATEX) $(document).tex

clean:
	rm -f *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
	rm -f contrib/*.aux parts/*.aux

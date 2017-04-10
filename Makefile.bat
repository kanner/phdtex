set texlive_bin=C:\texlive\2014\bin\win32
# dirty hack -- set perl_bin
for /f "delims=" %%i in ('where /R %LOCALAPPDATA%\GitHub perl') do set perl_bin=%%i

# dissertation
%texlive_bin%\pdflatex.exe dissertation.tex
%texlive_bin%\bibtex.exe dissertation
%perl_bin% .\contrib\bbl-sorter.pl
%texlive_bin%\makeindex.exe dissertation.nlo -s nomencl.ist -o dissertation.nls
%texlive_bin%\pdflatex.exe dissertation.tex
# some elements (bib, nom) could not be build
%texlive_bin%\pdflatex.exe dissertation.tex
%texlive_bin%\pdflatex.exe dissertation.tex

# synopsis
%texlive_bin%\pdflatex.exe synopsis.tex
%texlive_bin%\bibtex.exe synopsis1
%texlive_bin%\bibtex.exe synopsis2
%texlive_bin%\bibtex.exe synopsis3
%texlive_bin%\pdflatex.exe synopsis.tex
# some elements (bib) could not be build
%texlive_bin%\pdflatex.exe synopsis.tex

# booklet
%texlive_bin%\pdflatex.exe booklet.tex

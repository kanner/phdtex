@echo off

del *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
::del %path%\contrib\*.aux
del parts\*.aux parts\*.bbl parts\*.blg
del synopsis-parts\*.aux synopsis-parts\*.bbl synopsis-parts\*.blg

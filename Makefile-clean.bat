@echo off

:: set path for local or template-usecase
if "%~1"=="" (
	set mypath=
) else (
	set mypath=%~1
)

del *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg
del %mypath%contrib\*.aux
del parts\*.aux parts\*.bbl parts\*.blg
del synopsis-parts\*.aux synopsis-parts\*.bbl synopsis-parts\*.blg

::
:: phdtex
::
:: Copyright (c) 2014-2017, Andrew Kanner <andrew.kanner@gmail.com>.
:: All rights reserved.
::
:: SPDX-License-Identifier: MIT
::

@echo off

::set texlive_bin=C:\texlive\2014\bin\win32\
::set texlive_bin=D:\programs\texlive\2016\bin\win32\
:: it should work if LaTeX distribution is correctly set in %PATH%
set texlive_bin=
:: set perl_bin - only works with GitHub client installed
::for /f "delims=" %%i in ('where /R %LOCALAPPDATA%\GitHub perl') do set perl_bin=%%i
:: set perl_bin for http://strawberryperl.com/
set perl_bin=perl

:: set path for local or template-usecase
if "%~1"=="" (
	set mypath=
) else (
	set mypath=%~1
)

set dissertation=dissertation
set dissertation-bib=dissertation
set synopsis=synopsis
set synopsis-bib=synopsis
set booklet=booklet

:: dissertation
%texlive_bin%pdflatex.exe %dissertation%.tex || goto :error
%texlive_bin%bibtex.exe %dissertation-bib% || goto :error
%perl_bin% %mypath%contrib\bbl-sorter.pl || goto :error
%texlive_bin%makeindex.exe %dissertation-bib%.nlo -s nomencl.ist -o %dissertation-bib%.nls || goto :error
%texlive_bin%pdflatex.exe %dissertation%.tex || goto :error
:: some elements (bib, nom) could not be build
%texlive_bin%pdflatex.exe %dissertation%.tex || goto :error
%texlive_bin%pdflatex.exe %dissertation%.tex || goto :error

:: synopsis
%texlive_bin%pdflatex.exe %synopsis%.tex || goto :error
%texlive_bin%bibtex.exe %synopsis-bib%1 || goto :error
%texlive_bin%bibtex.exe %synopsis-bib%2 || goto :error
%texlive_bin%bibtex.exe %synopsis-bib%3 || goto :error
%texlive_bin%pdflatex.exe %synopsis%.tex || goto :error
:: some elements (bib) could not be build
%texlive_bin%pdflatex.exe %synopsis%.tex || goto :error

:: booklet
%texlive_bin%pdflatex.exe %booklet%.tex || goto :error

:: succeeded
goto :EOF

:error
echo Failed with error #%errorlevel%. Check the error messages above...
pause
exit /b %errorlevel%

@echo off

set texlive_bin=C:\texlive\2014\bin\win32
::set texlive_bin=D:\programs\texlive\2016\bin\win32
:: set perl_bin - only works with GitHub client installed
for /f "delims=" %%i in ('where /R %LOCALAPPDATA%\GitHub perl') do set perl_bin=%%i

:: set path for local or template-usecase
if "%~1"=="" set path=.
else set path=%~1

set dissertation=%path%\dissertation
set dissertation-bib=dissertation
set synopsis=%path%\synopsis
set synopsis-bib=synopsis
set booklet=%path%\booklet

:: dissertation
%texlive_bin%\pdflatex.exe %dissertation%.tex || goto :error
%texlive_bin%\bibtex.exe %dissertation-bib% || goto :error
%perl_bin% %path%\contrib\bbl-sorter.pl || goto :error
%texlive_bin%\makeindex.exe %dissertation%.nlo -s nomencl.ist -o %dissertation%.nls || goto :error
%texlive_bin%\pdflatex.exe %dissertation%.tex || goto :error
:: some elements (bib, nom) could not be build
%texlive_bin%\pdflatex.exe %dissertation%.tex || goto :error
%texlive_bin%\pdflatex.exe %dissertation%.tex || goto :error

:: synopsis
%texlive_bin%\pdflatex.exe %synopsis%.tex || goto :error
%texlive_bin%\bibtex.exe %synopsis-bib%1 || goto :error
%texlive_bin%\bibtex.exe %synopsis-bib%2 || goto :error
%texlive_bin%\bibtex.exe %synopsis-bib%3 || goto :error
%texlive_bin%\pdflatex.exe %synopsis%.tex || goto :error
:: some elements (bib) could not be build
%texlive_bin%\pdflatex.exe %synopsis%.tex || goto :error

:: booklet
%texlive_bin%\pdflatex.exe %booklet%.tex || goto :error

:: succeeded
goto :EOF

:error
echo Failed with error #%errorlevel%. Check the error messages above...
::pause
exit /b %errorlevel%

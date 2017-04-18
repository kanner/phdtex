@echo off

del *.aux *.log *.ps *.lof *.lot *.out *.toc *.pdf *.blg *.bbl *.nls *.nlo *.ilg || goto :error
::del %path%\contrib\*.aux || goto :error
del parts\*.aux parts\*.bbl parts\*.blg || goto :error
del synopsis-parts\*.aux synopsis-parts\*.bbl synopsis-parts\*.blg || goto :error

:: succeeded
goto :EOF

:error
echo Failed with error #%errorlevel%. Check the error messages above...
::pause
exit /b %errorlevel%

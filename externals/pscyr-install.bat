::
:: phdtex
::
:: Copyright (c) 2014-2017, Andrew Kanner <andrew.kanner@gmail.com>.
:: All rights reserved.
::
:: SPDX-License-Identifier: MIT
::

:: This script is used to install pscyr in system and enable it.

@echo off

:: this first path should be set manually
set texlive_dir=C:\texlive
::set texlive_dir=D:\programs\texlive
set pscyr_bin=%texlive_dir%\PSCyr

:: download pscyr packages (source -- gentoo
:: dev-tex/pscyr/pscyr-0.4d_beta9.ebuild)
powershell -Command "(New-Object Net.WebClient).DownloadFile('ftp://scon155.phys.msu.su/pub/russian/psfonts/0.4d-beta/PSCyr-0.4-beta9-tex.tar.gz', '%texlive_dir%\PSCyr-0.4-beta9-tex.tar.gz')"
powershell -Command "(New-Object Net.WebClient).DownloadFile('ftp://scon155.phys.msu.su/pub/russian/psfonts/0.4d-beta/PSCyr-0.4-beta9-type1.tar.gz', '%texlive_dir%\PSCyr-0.4-beta9-type1.tar.gz')"

:: uncompressing is not included in this script
echo Please uncompress (to current directory) downloaded tag.gz-archives in "%texlive_dir%" (it's software-specific, use winrar or 7zip) and press some key when done.
pause

:: create font directory structure (encoding+font)
mkdir %texlive_dir%\texmf-local\fonts\enc\dvips\pscyr
mkdir %texlive_dir%\texmf-local\fonts\map\dvips\pscyr
mkdir %texlive_dir%\texmf-local\tex\latex\pscyr

:: copy font data
copy %pscyr_bin%\dvips\pscyr\t2a.enc %texlive_dir%\texmf-local\fonts\enc\dvips\pscyr\
copy %pscyr_bin%\dvips\pscyr\pscyr.map %texlive_dir%\texmf-local\fonts\map\dvips\pscyr\
copy %pscyr_bin%\tex\latex\pscyr\* %texlive_dir%\texmf-local\tex\latex\pscyr\
xcopy /E %pscyr_bin%\dvipdfm %texlive_dir%\texmf-local\dvipdfm\
xcopy /E %pscyr_bin%\fonts %texlive_dir%\texmf-local\fonts\

:: enable pscyr:
:: update indexes with "make TeX ls -R"
mktexlsr
texhash
:: update file mapping (dvipdfmx, dvips, pdftex, etc)
updmap-sys
:: force enable pscyr-map
updmap-sys --enable Map pscyr.map

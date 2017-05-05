phdtex [for English users]
==========================

PhD latex template more or less satisfying the requirements of
Russian-specific GOST R 7.0.11-2011 (dissertation text, synopsis).

Read this in other languages:
[Russian](https://github.com/kanner/phdtex/blob/master/README.md).

## Acknowledgment

This project is build while preparing my PhD dissertation and is
actual as for now in 2017, but I don't guarantee that it's
**completely** satisfy GOST R 7.0.11-2011. The project is inspired by
[Russian-Phd-LaTeX-Dissertation-Template](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template)
(till
[703e978](https://github.com/AndreyAkinshin/Russian-Phd-LaTeX-Dissertation-Template/commit/703e978ce7214d4557a710c34f4f2f216292d387)
commit) but has different license (see Licenses section below) &ndash;
the original project has no OSS license neither now (CC-BY-4.0), nor
on the commit above.

## Directories structure

* **./**: main data and build files
  * data files: author info, title, chapters, conclusion
  * build files: dissertation, synopsis, booklet (for synopsis)
  * Makefiles (both shell and batch scripts for Linux and Windows)
* **./contrib**: main template-related files
  * packages and some naming rules (partially Russian-specific)
  * table of contents
  * styles (including separate GOST-style file)
  * bst-style and bibliography sorter script (GOST 7.1-2003 +
    7.0.11-2011 requirements)
* **./externals**: pscyr installation scripts, original project'
    submodule
* **./images**: images destination folder
* **./parts**: miscellaneous files used in dissertation
  * appendices
  * bibliography database examples (separate for
    standart/[VAK](http://vak.ed.gov.ru/)/[Scopus](https://www.elsevier.com/solutions/scopus/content)
    publications, with sheet count)
  * intro wrappers (separate for dissertation and synopsis)
  * references: list of figures/tables, nomenclature
* **./synopsis-parts**: main synopsis data and template files
  * synopsis title
  * main content
  * results
  * references

## Pre-Requirements

To build the project you should install in Windows or Linux
environment at least two software packages:
* [_texlive_](https://www.tug.org/texlive/) (tested on 2014-2016
  versions);
* _pscyr_ font (see _./externals_ for installation scripts).

For Windows two more dependency exist:
* [_GitHub_](https://desktop.github.com/) client (or native perl
  installation to execute `Makefile.bat`);
* _powershell_ for `externals/pscyr-install.bat`.

For Linux you can additionally use _make_ utility and supplied
Makefile (see below). To use spellcheck (`make spell`; `make
spelltmpl`, `make spelldata`) _aspell_ package should be installed.

## Clone and build

To clone repository with submodule sync you can use the command:
```
git clone --recursive https://github.com/kanner/phdtex.git
```
or for already cloned repository:
```
git submodule update --init --recursive
```

To build the project you can use `pdflatex` manually, `Makefile.bat`
in Windows environment or Linux `make` without options or specifying
the following targets to build:
* `make` or `make all` &ndash; build dissertation.pdf, synopsis.pdf,
  booklet.pdf
* `make dissertation` &ndash; build dissertation.pdf
* `make synopsis` &ndash; build synopsis.pdf (build dissertation.pdf
  first)
* `make booklet` &ndash; build booklet.pdf (build synopsis.pdf first)
* `make spell` &ndash; call spellcheck for all files
* `make spelltmpl` &ndash; call spellcheck for template-related files
* `make spelldata` &ndash; call spellcheck for data files
* `make clean` &ndash; clean all temporary and builded files

The build process consists of several iterations of `pdflatex`
invocations (4 for dissertation text and 3 for synopsis) combined with
`bibtex` and `makeindex` in order to correctly build bibliography and
nomenclature. My test cases made it clear that this is currently the
optimal solution, although the build process is rather slow. To speed
up the build process Linux users can call above commands as `make
TARGET -jN` (_N_ could equal _(number of CPU cores) + 1_), all the
_TARGET_ dependencies should be correctly resolved.

## Using the project as a template

You can fork the project and make changes in it's original
files. Otherwise you can use the project as a template (git submodule
in _./template_ path, for example), copy all data files to other
project and use this simplified Makefiles with lines:
* _Makefile_:
```
template = ./template/
include $(template)/Makefile
```
* _Makefile.bat_: `call template\Makefile.bat template`
* _Makefile-clean.bat_: `call template\Makefile-clean.bat template`

To use template with [_texstudio_](http://www.texstudio.org/) or
similar latex environments you should also copy _dissertation.tex_,
_synopsis.tex_ and _booklet.tex_ to your project' root folder (the
ones from
[**texstudio-template**](https://github.com/kanner/phdtex/tree/texstudio-template)
branch).

## Limitations

There is currently no solution to make presentation document (with
_beamer_, for example). I used .ppt format for presentation because
using latex for this was not my target. If you want to use latex for
presentation &ndash; check current version of submodule in
_./externals_.

## Licenses (mixed licensing)

The main content of this project is licensed under the **MIT** license
**[SPDX-License-Identifier: MIT]** unless otherwise specified in the
file headers. It should be used as a template for PhD dissertation
and, as I think, represents source code in latex that should be
build/compiled with Makefiles or manually with `pdflatex`. Some
content have **Creative Commons Attribution 4.0** license
**[SPDX-License-Identifier: CC-BY-4.0]**: not template-related data
files (see objects without `$(template)/` prefix in _Makefile_) that
you can use, change or delete if you wish &ndash; author info,
introduction, parts of the main text and synopsis, bibtex files,
etc. Two more files (_contrib/tweaklist.sty_,
_contrib/utf8gost71my.bst_) has **LPPL** license and were modified by
me a little (copyright added). Images examples in _./images_ have
**CC0** license.

So, summarizing all of the above, I don't pretend on your data files
authorship, you should use the project as a template and check
licenses limitations for template-related content. Also the licenses
doesn't affect resultant pdf files (only if they're build with default
data files &ndash; in this case they're licensed under CC-BY-4.0 like
the data files themselves), you should only use them for original
source files from this repository. But you can thank me in one of the
last sections of your dissertation as well as your mentor/supervisor,
or you can not do this at all &ndash; it's your choice.

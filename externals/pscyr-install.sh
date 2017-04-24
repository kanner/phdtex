#!/bin/bash
#
# phdtex
#
# Copyright (c) 2014-2017, Andrew Kanner <andrew.kanner@gmail.com>.
# All rights reserved.
#
# SPDX-License-Identifier: MIT
#

# This script is used to install pscyr in system and enable it for
# current user (for other users you should first execute last
# command).
set -ex

# you can use other path instead of this global with some additional
# magic
texlive_dir=/usr/share/texmf/
pscyr_bin=${texlive_dir}/PSCyr/

# download pscyr packages (source -- gentoo
# dev-tex/pscyr/pscyr-0.4d_beta9.ebuild)
sudo wget ftp://scon155.phys.msu.su/pub/russian/psfonts/0.4d-beta/PSCyr-0.4-beta9-tex.tar.gz -P ${texlive_dir}
sudo wget ftp://scon155.phys.msu.su/pub/russian/psfonts/0.4d-beta/PSCyr-0.4-beta9-type1.tar.gz -P ${texlive_dir}
sudo tar xzf ${texlive_dir}/PSCyr-0.4-beta9-tex.tar.gz -C ${texlive_dir}
sudo tar xzf ${texlive_dir}/PSCyr-0.4-beta9-type1.tar.gz -C ${texlive_dir}

# create font directory structure (encoding+font)
sudo mkdir -p ${texlive_dir}/fonts/{enc,map}/dvips/pscyr
sudo mkdir -p ${texlive_dir}/tex/latex/pscyr

# copy font data
sudo cp ${pscyr_bin}/dvips/pscyr/t2a.enc ${texlive_dir}/fonts/enc/dvips/pscyr/
sudo cp ${pscyr_bin}/dvips/pscyr/pscyr.map ${texlive_dir}/fonts/map/dvips/pscyr/
sudo cp ${pscyr_bin}/tex/latex/pscyr/* ${texlive_dir}/tex/latex/pscyr/
sudo cp -pr ${pscyr_bin}/dvipdfm ${texlive_dir}/
sudo cp -pr ${pscyr_bin}/fonts ${texlive_dir}/

# enable pscyr:
# update indexes with "make TeX ls -R"
sudo mktexlsr
sudo texhash
# update file mapping (dvipdfmx, dvips, pdftex, + force enable
# pscyr-map)
updmap --enable Map pscyr.map
updmap


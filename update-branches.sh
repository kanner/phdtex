#!/bin/bash
set -ex

# branches should be local
#git fetch
#git checkout remotes/origin/texstudio-template && git checkout -b texstudio-template
#git checkout remotes/origin/texlive-2014 && git checkout -b texlive-2014
#git checkout remotes/origin/texlive-2018-fancyhdr && git checkout -b texlive-2018-fancyhdr
#git checkout remotes/origin/texlive-2018-fancyhdr-opp1_5 && git checkout -b texlive-2018-fancyhdr-opp1_5
#git checkout remotes/origin/texlive-2018+texstudio && git checkout -b texlive-2018+texstudio
#git checkout remotes/origin/texlive-2018+texstudio-stperl && git checkout -b texlive-2018+texstudio-stperl
# make changes in master
git checkout texstudio-template && git rebase master
git checkout texlive-2014 && git rebase master
git checkout texlive-2018-fancyhdr && git rebase master
git checkout texlive-2018-fancyhdr-opp1_5 && git rebase master
git checkout texlive-2018+texstudio && git rebase texlive-2018-fancyhdr
git checkout texlive-2018+texstudio-stperl && git rebase texlive-2018+texstudio
git checkout master
git push -f --all -u okbrepo && git push -f --all -u origin

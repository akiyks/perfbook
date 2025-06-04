#! /bin/bash -f

NPROC=`nproc --all`
make -j $NPROC contrib.tex origpub.tex sub_qqz
#
make LATEX=pdflatex 2c &
make LATEX=pdflatex-dev 1c &
make LATEX=lualatex eb &
make LATEX=lualatex-dev ebsf &
#
wait

#! /bin/bash -f

NPROC=`nproc --all`
PDFLATEX_CMD=`command -v pdflatex`
PDFLATEX_DEV_CMD=`command -v pdflatex-dev`
LUALATEX_CMD=`command -v lualatex`
LUALATEX_DEV_CMD=`command -v lualatex-dev`
#
make -j $NPROC contrib.tex origpub.tex sub_qqz
#
if [ $PDFLATEX_CMD != "" ] ; then
	make LATEX=pdflatex 2c &
fi
if [ $PDFLATEX_DEV_CMD != "" ] ; then
	make LATEX=pdflatex-dev 1c &
fi
if [ $LUALATEX_CMD != "" ] ; then
	make LATEX=lualatex eb &
fi
if [ $LUALATEX_DEV_CMD != "" ] ; then
	make LATEX=lualatex-dev ebsf &
fi
#
wait

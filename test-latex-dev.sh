#! /bin/bash -f
# Say "NODEV=1 ./test-latex-dev.sh" if pdflatex-dev doesn't work.

NPROC=`nproc --all`

PDFLATEX_CMD=`command -v pdflatex`
LUALATEX_CMD=`command -v lualatex`

if [ "x$NODEV" = "x" ] ; then
	PDFLATEX_DEV_CMD=`command -v pdflatex-dev`
	LUALATEX_DEV_CMD=`command -v lualatex-dev`
else
	PDFLATEX_DEV_CMD=
	LUALATEX_DEV_CMD=
fi
#
make -j $NPROC contrib.tex origpub.tex sub_qqz
#
LATEX_ENGINES=""
if [ "x$PDFLATEX_CMD" = "x" ] ; then
	LATEX_ENGINES="n$LATEX_ENGINES"
else
	LATEX_ENGINES="y$LATEX_ENGINES"
fi
if [ "x$PDFLATEX_DEV_CMD" = "x" ] ; then
	LATEX_ENGINES="n$LATEX_ENGINES"
else
	LATEX_ENGINES="y$LATEX_ENGINES"
fi
if [ "x$LUALATEX_CMD" = "x" ] ; then
	LATEX_ENGINES="n$LATEX_ENGINES"
else
	LATEX_ENGINES="y$LATEX_ENGINES"
fi
if [ "x$LUALATEX_DEV_CMD" = "x" ] ; then
	LATEX_ENGINES="n$LATEX_ENGINES"
else
	LATEX_ENGINES="y$LATEX_ENGINES"
fi

echo "latex engines: $LATEX_ENGINES"

case $LATEX_ENGINES in
	"yyyy")
		make LATEX=pdflatex 2c &
		make LATEX=pdflatex-dev 1c &
		make LATEX=lualatex eb &
		make LATEX=lualatex-dev ebsf &
		;;
	"nyny")
		make LATEX=pdflatex 2c &
		make LATEX=pdflatex 1c &
		make LATEX=lualatex eb &
		make LATEX=lualatex ebsf &
		;;
	"nnyy")
		make LATEX=pdflatex 2c &
		make LATEX=pdflatex-dev 1c &
		make LATEX=pdflatex eb &
		make LATEX=pdflatex-dev ebsf &
		;;
	*)
		echo "Unexpected list of availabe latex engines"
		exit 1

	esac
#
wait

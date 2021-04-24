#!/bin/sh

tex_sources_all=`find . -name "*.tex" -print`
tex_sources=""

for f in $tex_sources_all
do
	case $f in
	./perfbook*) ;;
	./qqz*) ;;
	./future/HTMtable*) ;;
	./appendix/styleguide*) ;;
	*) tex_sources="$tex_sources $f" ;;
        esac
done

for g in $tex_sources
do
	utilities/fullstopcheck.pl $g
done

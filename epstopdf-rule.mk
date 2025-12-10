# SPDX-License-Identifier: GPL-2.0-or-later
#
# Copyright (C) Akira Yokosawa, 2021
#
# Authors: Akira Yokosawa <akiyks@gmail.com>

EPSTOPDF := $(shell $(WHICH) epstopdf 2>/dev/null)
GS_953_OR_LATER := $(shell gs --version | grep -c -E "^(9\.5[3-9]|10\.[0-9]).?")
GS_OPT=--gsopt=-dPDFSETTINGS=/ebook

$(PDFTARGETS_OF_GNUPLOT_NEEDFIXFONTS): $(FIXFONTS)
$(PDFTARGETS_OF_GNUPLOT_NEEDFIXFONTS): %.pdf: %.eps
	@echo "$< --> $(suffix $@)"
ifndef EPSTOPDF
	$(error $< --> $@: epstopdf not found. Please install it)
endif
	@TMP=`mktemp -d` && \
	    sh $(FIXFONTS) < $< > $$TMP/$(notdir $(basename $<)__.eps) && \
	    eps2eps $$TMP/$(notdir $(basename $<)__.eps) $$TMP/$(notdir $(basename $<)___.eps) && \
	    epstopdf $(GS_OPT) $$TMP/$(notdir $(basename $<)___.eps) $$TMP/$(notdir $@) && \
	    mv -f $$TMP/$(notdir $@) $@ && \
	    rm -rf $$TMP

$(PDFTARGETS_OF_TEX): %.pdf: %.eps
	@echo "$< --> $(suffix $@)"
ifndef EPSTOPDF
	$(error $< --> $@: epstopdf not found. Please install it)
endif
ifeq ($(GS_953_OR_LATER),1)
	@TMP=`mktemp -d` && \
	    cp $< $$TMP/$(notdir $<) && \
	    eps2eps -dALLOWPSTRANSPARENCY $$TMP/$(notdir $<) $$TMP/$(notdir $(basename $<)__.eps) && \
	    epstopdf --gsopt=-dALLOWPSTRANSPARENCY $(GS_OPT) $$TMP/$(notdir $(basename $<)__.eps) $$TMP/$(notdir $@) && \
	    mv -f $$TMP/$(notdir $@) $@ && \
	    rm -rf $$TMP
else
	@TMP=`mktemp -d` && \
	    cp $< $$TMP/$(notdir $<) && \
	    eps2eps -dNOSAFER $$TMP/$(notdir $<) $$TMP/$(notdir $(basename $<)__.eps) && \
	    epstopdf --nosafer $(GS_OPT) $$TMP/$(notdir $(basename $<)__.eps) $$TMP/$(notdir $@) && \
	    mv -f $$TMP/$(notdir $@) $@ && \
	    rm -rf $$TMP
endif

$(PDFTARGETS_OF_EPSORIG_NOFIXFONTS) $(PDFTARGETS_OF_EPSOTHER): %.pdf: %.eps
	@echo "$< --> $(suffix $@)"
ifndef EPSTOPDF
	$(error $< --> $@: epstopdf not found. Please install it)
endif
	@TMP=`mktemp -d` && \
	    cp $< $$TMP/$(notdir $<) && \
	    eps2eps $$TMP/$(notdir $<) $$TMP/$(notdir $(basename $<)__.eps) && \
	    epstopdf $(GS_OPT) $$TMP/$(notdir $(basename $<)__.eps) $$TMP/$(notdir $@) && \
	    mv -f $$TMP/$(notdir $@) $@ && \
	    rm -f $$TMP/$(basename $<)__.eps

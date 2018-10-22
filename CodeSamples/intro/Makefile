ARCH_INDEPENDENT = initraceperf lockinc nakedinc perthreadinc threadcreate
ARCH_DEPENDENT = initrace
PROGS = $(ARCH_DEPENDENT) $(ARCH_INDEPENDENT)

top := ..
include $(top)/depends.mk

ifeq ($(strip $(target)),)
all: $(ARCH_INDEPENDENT)
	@echo "### $(ARCH_DEPENDENT) in intro/ can't be built on arch: '$(arch)'."
else
all: $(PROGS)
endif

include $(top)/recipes.mk

initrace: initrace.c ../api.h
	cc -g -Wall -pthread -o initrace initrace.c

initraceperf: initraceperf.c ../api.h
	cc -g -Wall -pthread -o initraceperf initraceperf.c

lockinc: lockinc.c ../api.h
	cc -g -Wall -pthread -o lockinc lockinc.c

nakedinc: nakedinc.c ../api.h
	cc -g -Wall -pthread -o nakedinc nakedinc.c

perthreadinc: perthreadinc.c ../api.h
	cc -g -Wall -pthread -o perthreadinc perthreadinc.c

threadcreate: threadcreate.c ../api.h
	cc -g -Wall -pthread -o threadcreate threadcreate.c

clean:
	rm -f $(PROGS)

.PHONY: all clean install

ifndef BUILDDIR
	BUILDDIR = $(realpath ../..)
endif

include $(BUILDDIR)/common.mk

ifdef APPS_LOCAL
	apps := $(APPS_LOCAL)
else 
	apps := $(patsubst %.mk,%,$(wildcard *.mk))
endif

all: ${apps}
install: $(foreach t,${apps},${t}-install)
clean: $(foreach t,${apps},${t}-clean)

include $(foreach t,${apps},${t}.mk)

# Bitscope Makefile
# root level
# Mischa Lehmann <ducksource@duckpond.ch>
# vim: set noexpandtab list:

#Variables
WORK_DIR := $(shell pwd)
TOPLEVEL := $(shell git rev-parse --show-toplevel)
REMOTE_C := $(shell git remote | wc -l)
MODULES := dso logic meter chart bitscope

#PROGRAMS
MAKEPKG := makepkg

.PHONY: all
all : update init pkg

.PHONY: update
update:
	if [ $(REMOTE_C) -gt 0 ];then\
	    git pull;\
	fi

.PHONY: init
init:
	. $(TOPLEVEL)/init.sh $(WORK_DIR) ;\
	defineVars ;\
	newlineIFS ;\
	for tmpl in $$(find $(TOPLEVEL) -name PKGBUILD.template ) ; do \
	    tmpl_dst="$$(dirname $${tmpl})/PKGBUILD" ;\
	    cp "$${tmpl}" "$${tmpl_dst}" ;\
	    replaceVars "$${tmpl_dst}" ;\
	done ;\
	restoreIFS ;\

.PHONY: pkg
pkg: init
	for module in $(MODULES) ; do \
	  cd $(TOPLEVEL)/$${module} ;\
	  $(MAKEPKG) -f -S ;\
	done

.PHONY: clean 
clean:
	git clean -f -d

.PHONY: install
install: pkg
	$(MAKE) -C pkg install


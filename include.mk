# Bitscope Makefile
# root level
# Mischa Lehmann <ducksource@duckpond.ch>
# vim: set noexpandtab list:

TOPLEVEL ?= $(shell git rev-parse --show-toplevel)
include $(TOPLEVEL)/vars.mk

.PHONY: all
all: update pkg

.PHONY: update
update:
	if [ $(REMOTE_C) -gt 0 ];then\
	    git pull;\
	fi

.PHONY: pkg
pkg:
	NAME=$(MODULE_NAME) ;\
	source $(INIT.SH) "$(TOPLEVEL)" ;\
	defineVars ;\
	cp "$(TEMPLATE)" "PKGBUILD" ;\
	replaceVars "PKGBUILD" ;\
	updpkgsums ;\
	mksrcinfo
	$(MAKEPKG) -f -S

.PHONY: intall
install: pkg
	$(MAKEPKG) -f ;\
	sudo pacman -U *$(MODULE_NAME)-$(VERSION)-$(REL)-*.tar.xz

.PHONY: release
release: pkg
	git commit -a -m "Release $(VERSION)-$(REL) @ $(DATE)"
	git push

.PHONY: clean 
clean:
	rm -rf ./src \
	       ./pkg \
	       *.deb \
	       *.tar.gz \
	       *.tar.xz \
	       PKGBUILD \
	       .SRCINFO


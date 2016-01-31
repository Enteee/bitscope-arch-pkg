# Bitscope Makefile
# root level
# Mischa Lehmann <ducksource@duckpond.ch>
# vim: set noexpandtab list:

#Variables
WORK_DIR := $(shell pwd)
REMOTE_C := $(shell git remote | wc -l)
TEMPLATE := $(TOPLEVEL)/PKGBUILD.template
MODULES := dso logic meter chart server bitscope
MODULE_NAME := $(basename $(notdir $(WORK_DIR)))
INIT.SH := $(TOPLEVEL)/init.sh

#PROGRAMS
MAKEPKG := makepkg


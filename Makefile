# Bitscope Makefile
# root level
# Mischa Lehmann <ducksource@duckpond.ch>
# vim: set noexpandtab list:

include include.mk

.DEFAULT_GOAL = all

.PHONY: all
all: TARGET ?= module
all: $(MODULES)

.PHONY: clean 
clean: TARGET ?= clean
clean: $(MODULES)

.PHONY: $(MODULES)
$(MODULES):
	$(MAKE) $(TARGET) \
	--directory=$@



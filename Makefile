# Bitscope Makefile
# root level
# Mischa Lehmann <ducksource@duckpond.ch>
# vim: set noexpandtab list:

include vars.mk

.DEFAULT_GOAL = all

.PHONY: all clean install
all clean install: $(MODULES)

.PHONY: $(MODULES)
$(MODULES):
	$(MAKE) $(MAKECMDGOALS) \
	--directory=$@



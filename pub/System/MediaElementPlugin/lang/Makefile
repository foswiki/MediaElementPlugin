FOSWIKI_ROOT?=~/foswiki/core
TARGET=$(shell ls -1 ../git/build/lang/*js 2>/dev/null|sed 's/^.*\/lang\///')

.PRECIOUS: %.uncompressed.js

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

ifneq (,$(wildcard ../git))
%.uncompressed.js: ../git/build/lang/%.js
	@echo copying $@
	@$(CAT) $^ > $@
endif


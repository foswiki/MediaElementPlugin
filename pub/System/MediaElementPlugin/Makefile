FOSWIKI_ROOT?=~/foswiki/core

TARGET= \
  build \
  build/pkg.js \
  build/pkg.css \
  build/mejs-controls.svg

SUBDIRS=lang

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

.PHONY: git

.PRECIOUS: %.uncompressed.js

git:
	git clone https://github.com/mediaelement/mediaelement.git git

	
build/%.js: build/%.uncompressed.js
	@echo minifying $@ from $<
	@$(JSMIN) $< > $@; \

build/pkg.uncompressed.js: $(LIB_DIR)/mediaelement-and-player.js $(SRC_DIR)/mediaelement.init.uncompressed.js $(SRC_DIR)/media_start.uncompressed.js
	@echo generating $@
	@$(CAT) $^ > $@

build/pkg.uncompressed.css: $(LIB_DIR)/mediaelementplayer.css $(SRC_DIR)/styles.uncompressed.css
	@echo getting from upstream $@
	@$(CAT) $^ > $@

ifneq (,$(wildcard git))
$(LIB_DIR)/%: git/build/%
	@echo getting from upstream $@
	@$(CAT) $^ > $@

build/%: git/build/%
	@echo getting from upstream $@
	@$(CAT) $^ > $@
endif

clean:
	rm -f build/*

build:
	@mkdir build

FOSWIKI_ROOT?=~/foswiki/core

TARGET= \
  $(BUILD_DIR)/pkg.js \
  $(BUILD_DIR)/pkg.css \
  $(BUILD_DIR)/mejs-controls.png \
  $(BUILD_DIR)/mejs-controls.svg

SUBDIRS=lang

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

.PHONY: git

.PRECIOUS: %.uncompressed.js

git:
	git clone https://github.com/johndyer/mediaelement.git git

clean:
	rm -f $(TARGET) $(BUILD_DIR)/*

$(BUILD_DIR)/%.js: $(BUILD_DIR)/%.uncompressed.js
	@echo minifying $@ from $<
	@$(JSMIN) $< > $@; \

$(BUILD_DIR)/pkg.uncompressed.js: $(LIB_DIR)/mediaelement-and-player.js $(SRC_DIR)/mediaelement.init.uncompressed.js
	@echo generating $@
	@$(CAT) $^ > $@

$(BUILD_DIR)/pkg.uncompressed.css: $(LIB_DIR)/mediaelementplayer.css
	@echo getting from upstream $@
	@$(CAT) $^ > $@

ifneq (,$(wildcard git))
$(LIB_DIR)/%: git/build/%
	@echo getting from upstream $@
	@$(CAT) $^ > $@

$(BUILD_DIR)/%: git/build/%
	@echo getting from upstream $@
	@$(CAT) $^ > $@
endif


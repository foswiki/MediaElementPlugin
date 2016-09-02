FOSWIKI_ROOT?=~/foswiki/core
TARGET= \
  pkg.js \
  pkg.css \
  background.png \
  bigplay.fw.png \
  bigplay.png \
  bigplay.svg \
  controls.fw.png \
  controls.png \
  controls.svg \
  controls-ted.png \
  controls-wmp-bg.png \
  controls-wmp.png \
  flashmediaelement-cdn.swf \
  flashmediaelement.swf \
  loading.gif \
  mediaelement.js \
  mediaelementplayer.js \
  silverlightmediaelement.xap \
  skipback.png 

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include


.PHONY: git

git:
	git clone https://github.com/johndyer/mediaelement.git git

clean:
	rm $(TARGET) *.gz

pkg.uncompressed.js: mediaelement-and-player.uncompressed.js mediaelement.init.uncompressed.js
	@$(CAT) $^ > $@

pkg.uncompressed.css: mediaelementplayer.css mejs-skins.css
	@$(CAT) $^ > $@

ifneq (,$(wildcard git))
%.gif: git/build/%.gif
	@echo copying $@
	@$(CAT) $^ > $@

%.png: git/build/%.png
	@echo copying $@
	@$(CAT) $^ > $@

%.swf: git/build/%.swf
	@echo copying $@
	@$(CAT) $^ > $@

%.svg: git/build/%.svg
	@echo copying $@
	@$(CAT) $^ > $@

%.xap: git/build/%.xap
	@echo copying $@
	@$(CAT) $^ > $@

mejs-skins.uncompressed.css: git/build/mejs-skins.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement-and-player.uncompressed.js: git/build/mediaelement-and-player.js
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement.uncompressed.js: git/build/mediaelement.js
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement.uncompressed.css: git/build/mediaelement.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelementplayer.uncompressed.css: git/build/mediaelementplayer.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelementplayer.uncompressed.js: git/build/mediaelementplayer.js
	@echo copying $@
	@$(CAT) $^ > $@
endif


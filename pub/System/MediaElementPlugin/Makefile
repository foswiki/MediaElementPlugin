FOSWIKI_ROOT?=~/foswiki/core
TARGET= \
  mediaelement.init.js \
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
  mediaelement-and-player.js \
	mediaelement.js \
	mediaelementplayer.css \
	mediaelementplayer.js \
	mejs-skins.css \
	silverlightmediaelement.xap \
	skipback.png 

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

clean:
	rm $(TARGET) *.gz

%.gif: git/local-build/%.gif
	@echo copying $@
	@$(CAT) $^ > $@

%.png: git/local-build/%.png
	@echo copying $@
	@$(CAT) $^ > $@

%.swf: git/build/%.swf
	@echo copying $@
	@$(CAT) $^ > $@

%.svg: git/local-build/%.svg
	@echo copying $@
	@$(CAT) $^ > $@

%.xap: git/build/%.xap
	@echo copying $@
	@$(CAT) $^ > $@

mejs-skins.uncompressed.css: git/local-build/mejs-skins.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement-and-player.uncompressed.js: git/local-build/mediaelement-and-player.js
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement.uncompressed.js: git/local-build/mediaelement.js
	@echo copying $@
	@$(CAT) $^ > $@

mediaelement.uncompressed.css: git/local-build/mediaelement.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelementplayer.uncompressed.css: git/local-build/mediaelementplayer.css
	@echo copying $@
	@$(CAT) $^ > $@

mediaelementplayer.uncompressed.js: git/local-build/mediaelementplayer.js
	@echo copying $@
	@$(CAT) $^ > $@


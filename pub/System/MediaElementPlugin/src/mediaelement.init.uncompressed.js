"use strict";
jQuery(function($) {
  var defaults = {
    iconSprite: foswiki.getPreference("PUBURLPATH") + "/System/MediaElementPlugin/build/mejs-controls.svg"
  };

  $("audio.jqMediaElement, video.jqMediaElement").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.data());

    $this.mediaelementplayer(opts);
  });
});

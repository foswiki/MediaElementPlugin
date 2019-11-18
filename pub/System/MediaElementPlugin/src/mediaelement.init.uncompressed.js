"use strict";
jQuery(function($) {
  var defaults = {
    "stretching": "none"
  };

  $("audio.jqMediaElement, video.jqMediaElement").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.data());

    $this.mediaelementplayer(opts);
  });
});

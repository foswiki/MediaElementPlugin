"use strict";
jQuery(function($) {
  var defaults = {
  };

  $("audio.jqMediaElement, video.jqMediaElement").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.data());

    $this.mediaelementplayer(opts);
  });
});

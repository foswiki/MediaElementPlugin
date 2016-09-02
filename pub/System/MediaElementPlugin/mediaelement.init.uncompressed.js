"use strict";
jQuery(function($) {
  var defaults = {};

  $("audio,video").livequery(function() {
    var $this = $(this), 
        opts = $.extend({}, defaults, $this.data());

    $this.mediaelementplayer(opts);
  });
});

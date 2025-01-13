"use strict";
jQuery(function($) {

  $(document).on("click", ".jqMediaStart", function() {
    var $this = $(this), 
        opts = $this.data();
        select = '#' + opts.player + "_html5";

    $(select).each(function() {
      var player = $(this).data("mediaelementplayer");

      this.currentTime = opts.time;
      player.play();
    });

    return false;
  });

});

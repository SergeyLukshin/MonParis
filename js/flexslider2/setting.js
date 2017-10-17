(function($) {
	'use strict';
      $('.slider_top .flexslider').flexslider({
        animation: "fade",
        slideshow: true,
        animationLoop: true,
        directionNav: false
      });


      $('.clients .flexslider').flexslider({
        animation: "slide",
        animationLoop: false,
        itemWidth: 190,
        itemMargin: 0,
        minItems: 1,
        maxItems: 6,
        slideshow: false,
      });

       $('.certif .flexslider').flexslider({
        animation: "slide",
        animationLoop: false,
        itemWidth: 217,
        itemMargin: 0,
        minItems: 1,
        maxItems: 5,
        slideshow: false,
      });

})(jQuery);
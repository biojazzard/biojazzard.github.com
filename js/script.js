/*global jQuery */
/*!	
* Lettering.JS 0.6.1
*
* Copyright 2010, Dave Rupert http://daverupert.com
* Released under the WTFPL license 
* http://sam.zoy.org/wtfpl/
*
* Thanks to Paul Irish - http://paulirish.com - for the feedback.
*
* Date: Mon Sep 20 17:14:00 2010 -0600
*/
(function($){
	function injector(t, splitter, klass, after) {
		var a = t.text().split(splitter), inject = '';
		if (a.length) {
			$(a).each(function(i, item) {
				inject += '<span class="'+klass+(i+1)+'">'+item+'</span>'+after;
			});	
			t.empty().append(inject);
		}
	}

	var methods = {
		init : function() {

			return this.each(function() {
				injector($(this), '', 'char', '');
			});

		},

		words : function() {

			return this.each(function() {
				injector($(this), ' ', 'word', ' ');
			});

		},

		lines : function() {

			return this.each(function() {
				var r = "eefec303079ad17405c889e092e105b0";
				// Because it's hard to split a <br/> tag consistently across browsers,
				// (*ahem* IE *ahem*), we replaces all <br/> instances with an md5 hash 
				// (of the word "split").  If you're trying to use this plugin on that 
				// md5 hash string, it will fail because you're being ridiculous.
				injector($(this).children("br").replaceWith(r).end(), r, 'line', '');
			});

		}
	};

	$.fn.lettering = function( method ) {
		// Method calling logic
		if ( method && methods[method] ) {
			return methods[ method ].apply( this, [].slice.call( arguments, 1 ));
		} else if ( method === 'letters' || ! method ) {
			return methods.init.apply( this, [].slice.call( arguments, 0 ) ); // always pass an array
		}
		$.error( 'Method ' +  method + ' does not exist on jQuery.lettering' );
		return this;
	};

})(jQuery);/*global jQuery */
/*!	
* FitText.js 1.0
*
* Copyright 2011, Dave Rupert http://daverupert.com
* Released under the WTFPL license 
* http://sam.zoy.org/wtfpl/
*
* Date: Thu May 05 14:23:00 2011 -0600
*/

(function( $ ){
	
  $.fn.fitText = function( kompressor, options ) {
	   
    // Setup options
    var compressor = kompressor || 1,
        settings = $.extend({
          'minFontSize' : Number.NEGATIVE_INFINITY,
          'maxFontSize' : Number.POSITIVE_INFINITY
        }, options);
	
    return this.each(function(){

      // Store the object
      var $this = $(this); 
        
      // Resizer() resizes items based on the object width divided by the compressor * 10
      var resizer = function () {
        $this.css('font-size', Math.max(Math.min($this.width() / (compressor*10), parseFloat(settings.maxFontSize)), parseFloat(settings.minFontSize)));
      };

      // Call once to set.
      resizer();
				
      // Call on resize. Opera debounces their resize by default. 
      $(window).on('resize', resizer);
      	
    });

  };

})( jQuery );(function($, window, document) {
  var DOMSCROLL, DOWN, DRAG, MOUSEDOWN, MOUSEMOVE, MOUSEUP, MOUSEWHEEL, NanoScroll, PANEDOWN, RESIZE, SCROLL, SCROLLBAR, UP, WHEEL, getScrollbarWidth;
  SCROLLBAR = 'scrollbar';
  SCROLL = 'scroll';
  MOUSEDOWN = 'mousedown';
  MOUSEMOVE = 'mousemove';
  MOUSEWHEEL = 'mousewheel';
  MOUSEUP = 'mouseup';
  RESIZE = 'resize';
  DRAG = 'drag';
  UP = 'up';
  PANEDOWN = 'panedown';
  DOMSCROLL = 'DOMMouseScroll';
  DOWN = 'down';
  WHEEL = 'wheel';
  getScrollbarWidth = function() {
    var noscrollWidth, outer, yesscrollWidth;
    outer = document.createElement('div');
    outer.style.position = 'absolute';
    outer.style.width = '100px';
    outer.style.height = '100px';
    outer.style.overflow = 'scroll';
    document.body.appendChild(outer);
    noscrollWidth = outer.offsetWidth;
    yesscrollWidth = outer.scrollWidth;
    document.body.removeChild(outer);
    return noscrollWidth - yesscrollWidth;
  };
  NanoScroll = (function() {

    function NanoScroll(el) {
      this.el = el;
      this.generate();
      this.createEvents();
      this.addEvents();
      this.reset();
    }

    NanoScroll.prototype.createEvents = function() {
      var _this = this;
      this.events = {
        down: function(e) {
          _this.isDrag = true;
          _this.offsetY = e.clientY - _this.slider.offset().top;
          _this.pane.addClass('active');
          $(document).bind(MOUSEMOVE, _this.events[DRAG]);
          $(document).bind(MOUSEUP, _this.events[UP]);
          return false;
        },
        drag: function(e) {
          _this.sliderY = e.clientY - _this.el.offset().top - _this.offsetY;
          _this.scroll();
          return false;
        },
        up: function(e) {
          _this.isDrag = false;
          _this.pane.removeClass('active');
          $(document).unbind(MOUSEMOVE, _this.events[DRAG]);
          $(document).unbind(MOUSEUP, _this.events[UP]);
          return false;
        },
        resize: function(e) {
          _this.reset();
        },
        panedown: function(e) {
          _this.sliderY = e.clientY - _this.el.offset().top - _this.sliderH * 0.5;
          _this.scroll();
          _this.events.down(e);
        },
        scroll: function(e) {
          var content, top;
          content = _this.content[0];
          if (_this.isDrag === true) return;
          top = content.scrollTop / (content.scrollHeight - content.clientHeight) * (_this.paneH - _this.sliderH);
          _this.slider.css({
            top: top + 'px'
          });
        },
        wheel: function(e) {
          _this.sliderY += -e.wheelDeltaY || -e.delta;
          _this.scroll();
          return false;
        }
      };
    };

    NanoScroll.prototype.addEvents = function() {
      var events, pane;
      events = this.events;
      pane = this.pane;
      $(window).bind(RESIZE, events[RESIZE]);
      this.slider.bind(MOUSEDOWN, events[DOWN]);
      pane.bind(MOUSEDOWN, events[PANEDOWN]);
      this.content.bind(SCROLL, events[SCROLL]);
      if (window.addEventListener) {
        pane = pane[0];
        pane.addEventListener(MOUSEWHEEL, events[WHEEL], false);
        pane.addEventListener(DOMSCROLL, events[WHEEL], false);
      }
    };

    NanoScroll.prototype.removeEvents = function() {
      var events, pane;
      events = this.events;
      pane = this.pane;
      $(window).unbind(RESIZE, events[RESIZE]);
      this.slider.unbind(MOUSEDOWN, events[DOWN]);
      pane.unbind(MOUSEDOWN, events[PANEDOWN]);
      this.content.unbind(SCROLL, events[SCROLL]);
      if (window.addEventListener) {
        pane = pane[0];
        pane.removeEventListener(MOUSEWHEEL, events[WHEEL], false);
        pane.removeEventListener(DOMSCROLL, events[WHEEL], false);
      }
    };

    NanoScroll.prototype.generate = function() {
      this.el.append('<div class="pane"><div class="slider"></div></div>');
      this.content = $(this.el.children()[0]);
      this.slider = this.el.find('.slider');
      this.pane = this.el.find('.pane');
      this.scrollW = getScrollbarWidth();
      if (this.scrollbarWidth === 0) this.scrollW = 0;
      this.content.css({
        right: -this.scrollW + 'px'
      });
    };

    NanoScroll.prototype.reset = function() {
      if (this.isDead === true) {
        this.isDead = false;
        this.pane.show();
        this.addEvents();
      }
      this.contentH = this.content[0].scrollHeight + this.scrollW;
      this.paneH = this.pane.outerHeight();
      this.sliderH = this.paneH / this.contentH * this.paneH;
      this.sliderH = Math.round(this.sliderH);
      this.scrollH = this.paneH - this.sliderH;
      this.slider.height(this.sliderH);
      if (this.paneH >= this.content[0].scrollHeight) {
        this.pane.hide();
      } else {
        this.pane.show();
      }
    };

    NanoScroll.prototype.scroll = function() {
      var scrollValue;
      this.sliderY = Math.max(0, this.sliderY);
      this.sliderY = Math.min(this.scrollH, this.sliderY);
      scrollValue = this.paneH - this.contentH + this.scrollW;
      scrollValue = scrollValue * this.sliderY / this.scrollH;
      this.content.scrollTop(-scrollValue);
      return this.slider.css({
        top: this.sliderY
      });
    };

    NanoScroll.prototype.scrollBottom = function(offsetY) {
      this.reset();
      this.content.scrollTop(this.contentH - this.content.height() - offsetY);
    };

    NanoScroll.prototype.scrollTop = function(offsetY) {
      this.reset();
      this.content.scrollTop(offsetY + 0);
    };

    NanoScroll.prototype.stop = function() {
      this.isDead = true;
      this.removeEvents();
      this.pane.hide();
    };

    return NanoScroll;

  })();
  $.fn.nanoScroller = function(options) {
    var scrollbar;
    options || (options = {});
    if (!($.browser.msie && parseInt($.browser.version, 10) < 8)) {
      scrollbar = this.data(SCROLLBAR);
      if (scrollbar === void 0) {
        scrollbar = new NanoScroll(this);
        this.data(SCROLLBAR, scrollbar);
      }
      if (options.scrollBottom) {
        return scrollbar.scrollBottom(options.scrollBottom);
      }
      if (options.scrollTop) return scrollbar.scrollTop(options.scrollTop);
      if (options.scroll === 'bottom') return scrollbar.scrollBottom(0);
      if (options.scroll === 'top') return scrollbar.scrollTop(0);
      if (options.stop) return scrollbar.stop();
      scrollbar.reset();
    }
  };
})(jQuery, window, document);
/*
 * by Alfredo Llanos. 2012
 */
/*
 * by Alfredo Llanos. 2012
 */

jQuery(document).ready(function ($) {

  var iniColor;

  iniColor = $('body').attr('data-color');

  $('div[class^="boton bg-color-"]').each(function() {
    (function (el) {
      el.bind('click', function() {
        var tempClass,
        innerClass,
        innerClassCrop;

        clearColorChooser();

        tempClass = el.attr('class');
        iniColor = tempClass.replace('boton ', '');

        drawColorChooser();

        innerClass = $('.bgr').attr('class');
        innerClassCrop = innerClass.replace('bgr ', '');
        $('.bgr').removeClass(innerClassCrop);
        $('.bgr').addClass(iniColor);

        //el.addClass();
      });
      //console.log(el.attr('class'));
    })($(this));
    
  });

  function drawColorChooser() {

    var tempClass,
    innerClass,
    innerClassCrop;

    $('div[class^="boton bg-color-"]').each(function() {
      tempClass = $(this).attr('class');
      innerClassCrop = tempClass.replace('boton ', '');
      if (innerClassCrop === iniColor) {
        $(this).html('<i class="icon-eye-open"></i>');
      } else {
        $(this).html('&nbsp;');
      }
    });
  }

  function clearColorChooser() {

    $('div[class^="boton bg-color-"]').each(function() {
      $(this).html('&nbsp;');
    });

  }

  function resizeLogo(){

    var myWinW,
        brandImg;

    myWinW = $(window).width();
    brandImg = $('.brand-img').width();
    $('.brand-img').css('height', brandImg);
    console.log(myWinW);
    console.log(brandImg);

  }

  //$("h1").fitText();
  //$("h1").fitText(1.0, { minFontSize: '70px', maxFontSize: '72px' });


  $(window).resize(function() {
    resizeLogo();
  });

  resizeLogo();
  drawColorChooser();

});

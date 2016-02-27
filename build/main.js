(function() {
  var $, FastClick, Isotope, Skrollr, Snap, bootstrap, domready, flexslider, scrollReveal, smoothScroll;

  $ = require('jquery');

  domready = require('domready');

  FastClick = require('fastclick');

  bootstrap = require('bootstrap');

  smoothScroll = require('smoothScroll');

  scrollReveal = require('scrollReveal');

  flexslider = require('flexslider');

  Skrollr = require('skrollr');

  Isotope = require('isotope');

  Snap = require('snap');

  domready(function() {
    var alignBottom, alignPage, alignVertical, currentPad, dateFormatter, feat_container, handleMYTweets, handleTweets, height, isChrome, isFirefox, isIE, isSafari, iso_features, iso_projects, newHeight, newPad, prefix, pro_container, replaceArray, scrollTop, toBottom, _as, _eq_heights, _init, _last_tweets, _pointLess, _snap, _snap_it, _snap_logo, _th, _tw, _wh, _ww;
    isFirefox = typeof InstallTrigger !== "undefined";
    isIE = false || !!document.documentMode;
    isChrome = !!window.chrome;
    isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf("Constructor") > 0;
    prefix = void 0;
    if (isFirefox) {
      prefix = "-moz-";
    } else if (isIE) {
      prefix = "";
    } else {
      if (isChrome || isSafari) {
        prefix = "-webkit-";
      }
    }
    console.log("We are here---->");
    replaceArray = function(replaceString, find, replace) {
      var i;
      i = 0;
      while (i < find.length) {
        replaceString = replaceString.replace(find[i], replace[i]);
        i++;
      }
      return replaceString;
    };
    _eq_heights = function($item) {
      var h;
      h = 0;
      $item.each(function(index, val) {
        if ($(this).height() >= h) {
          return h = $(this).height();
        }
      });
      return $item.css({
        height: Math.floor(h),
        display: 'block'
      });
    };
    _wh = function() {
      return Math.floor($(window).height());
    };
    _ww = function() {
      return Math.floor($(window).width());
    };
    _th = function(selector) {
      var height;
      height = Math.floor($(selector).height());
      console.log('height' + selector + height);
      return height;
    };
    _tw = function(selector) {
      var width;
      width = Math.floor($(selector).width());
      console.log('width' + selector + width);
      return width;
    };
    _as = function(upSelector, downSelector) {
      if (upSelector == null) {
        upSelector = '.top-bar';
      }
      if (downSelector == null) {
        downSelector = '.navbar-fixed-bottom';
      }
      return Math.floor(_wh() - (_th(upSelector) + _th(downSelector)));
    };
    scrollTop = function() {
      if (window.pageYOffset !== undefined) {
        return window.pageYOffset;
      } else {
        return (document.documentElement || document.body.parentNode || document.body).scrollTop;
      }
    };
    _init = function() {
      if (!/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i.test(navigator.userAgent || navigator.vendor || window.opera)) {
        $("body").addClass("no-pointer");
      } else {
        $("body").addClass("pointer");
      }
      new FastClick(document.body);
      window.scrollTo(0, 0);
      $(".loader").css({
        opacity: 0
      });
      setTimeout(function() {
        return $(".loader").hide();
      }, 666);
      $(window).on('debouncedresize.general', function() {
        console.log("general----------------------------------");
        alignPage();
        alignVertical();
        alignBottom();
        toBottom();
        if (!$("nav").hasClass("overlay-bar") && !$("nav").hasClass("contained-bar")) {
          $(".main-container").first().css({
            "margin-top": $("nav").outerHeight()
          });
        }
        $(".subnav-fullwidth").each(function() {
          var containerOffset, offset;
          $(this).css({
            width: $(".container").width()
          });
          offset = $(this).closest(".has-dropdown").offset();
          offset = offset.left;
          containerOffset = _ww() - $(".container").outerWidth();
          containerOffset = containerOffset / 2;
          offset = offset - containerOffset - 15;
          return $(this).css({
            left: -offset
          });
        });
        if ($('#features-strip')) {
          if (_ww() >= 1024) {
            $('.feature-box').find('.btn').css({
              position: 'absolute',
              bottom: '10px'
            });
          } else {
            if (_wh() >= _ww()) {
              $('.feature-box').find('.btn').css({
                position: 'relative',
                bottom: 0
              });
            } else {
              $('.feature-box').find('.btn').css({
                position: 'relative',
                bottom: 0
              });
            }
          }
        }
        if ($('#children-boxes').size()) {
          if (_ww() >= 1024) {
            $('#children-boxes').css({
              'padding-top': _th('.top-bar'),
              height: Math.floor((_wh() - _th('.navbar-fixed-bottom')) * 0.66666)
            });
            $(".features-strip").css({
              height: Math.floor((_wh() - _th('.navbar-fixed-bottom')) * 0.33333)
            });
            $(".features-strip").find('.feature-box').css({
              'min-height': Math.floor((_wh() - _th('.navbar-fixed-bottom')) * 0.33333),
              display: 'block'
            });
            $('.pricing-table').css({
              height: $('#children-boxes').height() - 10,
              display: 'block'
            });
          } else {
            if (_wh() >= _ww()) {
              $('#children-boxes').css({
                'padding-top': _th('.top-bar') + 10
              });
              $(".features-strip").find('.feature-box').css({
                'min-height': 0,
                display: 'block'
              });
              $('.pricing-table').css({
                height: 'auto',
                'min-height': 0,
                display: 'block'
              });
            } else {
              $('#children-boxes').css({
                'padding-top': _th('.top-bar') + 10
              });
              $('.features-strip').find('.feature-box').css({
                'min-height': 0,
                display: 'block'
              });
            }
            _eq_heights($('.pricing-table'));
          }
        }
        if ($('.map-holder').size()) {
          if (_ww() >= 992) {
            $('.map-holder').css({
              height: _as()
            });
            $('.map-holder').find('iframe').css({
              height: '100%',
              width: '100%'
            });
            $('#mapa').find('.feature-box').css({
              'min-height': _as(),
              display: 'block'
            });
          } else {
            if (_wh() >= _ww()) {
              $('.map-holder').css({
                height: Math.round(_as() * 0.666666)
              });
              $('.map-holder').find('iframe').css({
                height: _as() * 0.666666,
                width: '100%'
              });
              $('#mapa').find('.feature-box').css({
                'min-height': Math.round(_as() * 0.333333),
                display: 'block'
              });
            } else {
              $('.map-holder').css({
                height: _as() * 0.666666
              });
              $('.map-holder').find('iframe').css({
                height: Math.round(_as() * 0.666666),
                width: '100%'
              });
              $('#mapa').find('.feature-box').css({
                'min-height': Math.round(_as() * 0.333333),
                display: 'block'
              });
            }
          }
        }
        $("#to-contact").smoothScroll({
          offset: -_th(".top-bar"),
          speed: 400
        });
        return $("#to-blog").smoothScroll({
          offset: -_th(".top-bar"),
          speed: 400
        });
      });
      setTimeout(function() {
        return $(window).trigger('debouncedresize.general');
      }, 888);
      $(window).scroll(function() {
        if ($(".map-holder").hasClass("on")) {
          $(".map-holder").removeClass("on");
        }
        if (scrollTop() > 180 && !$(".mobile-toggle").is(":visible")) {
          return $(".top-bar").addClass("nav-sticky");
        } else {
          return $(".top-bar").removeClass("nav-sticky");
        }
      });
      $(".offscreen-toggle").on('click', function() {
        $(".main-container").toggleClass("reveal-nav");
        $(".offscreen-container").toggleClass("reveal-nav");
        return $(".offscreen-menu .container").toggleClass("reveal-nav");
      });
      $(".main-container").on('click', function() {
        if ($(this).hasClass("reveal-nav")) {
          $(".main-container").toggleClass("reveal-nav");
          $(".offscreen-container").toggleClass("reveal-nav");
          return $(".offscreen-menu .container").toggleClass("reveal-nav");
        }
      });
      return $('.footer-container').css({
        'margin-bottom': Math.floor($("#navbar_footer").height())
      });
    };
    _snap_it = function(id) {
      var s, sData;
      if ($(id).size()) {
        s = void 0;
        sData = $(id).attr('data-src');
        return Snap.load(sData, function(loadedFragment) {
          s = Snap(id);
          return s.append(loadedFragment);
        });
      }
    };
    _snap_logo = function() {
      var s, sData;
      if ($("#logo").size()) {
        s = void 0;
        sData = $('#logo').attr('data-src');
        return Snap.load(sData, function(loadedFragment) {
          s = Snap("#logo");
          return s.append(loadedFragment);
        });
      }
    };
    _snap = function() {
      return $('.icon-img').each(function() {
        var $name, $sdata, lf, s, sdata;
        lf = void 0;
        s = void 0;
        sdata = void 0;
        $name = $(this).attr('data-name');
        $sdata = $(this).attr('data-src');
        return Snap.load($sdata, function(loadedFragment) {
          s = Snap("#snap-" + $name);
          return s.append(loadedFragment);
        });
      });
    };
    _pointLess = function() {
      return $('.point').each(function() {
        $(this).parent().css({
          display: 'block',
          'background-image': 'url(' + this.src + ')',
          'background-size': 'cover',
          'background-position': '50% 50%',
          'margin': '0 auto'
        }).addClass('processed');
        return $(this).css({
          display: 'none'
        }).attr('alt', '');
      });
    };
    handleTweets = function(tweets) {
      var element, html, n, x;
      x = tweets.length;
      n = 0;
      element = document.getElementById("tweets");
      html = "<ul class=\"slides\">";
      while (n < x) {
        html += "<li>" + tweets[n] + "</li>";
        n++;
      }
      html += "</ul>";
      return element.innerHTML = html;
    };
    alignPage = function() {
      return $(".align-page").each(function() {
        var height, padAmount, parentHeight;
        height = $(this).height();
        parentHeight = $(this).parent().height();
        padAmount = (parentHeight / 2) - (height / 2);
        $(this).css({
          "padding-top": _th('.top-bar') + (padAmount / 2)
        });
        return $(this).fadeIn('slow');
      });
    };
    alignVertical = function() {
      return $(".align-vertical").each(function() {
        var height, padAmount, parentHeight;
        height = $(this).height();
        parentHeight = $(this).parent().height();
        padAmount = (parentHeight / 2) - (height / 2);
        $(this).css({
          "padding-top": padAmount
        });
        return $(this).fadeIn('slow');
      });
    };
    alignBottom = function() {
      return $(".align-bottom").each(function() {
        var height, padAmount, parentHeight;
        height = $(this).height();
        parentHeight = $(this).parent().height();
        padAmount = parentHeight - height;
        $(this).css({
          "padding-top": padAmount
        });
        return $(this).fadeIn('slow');
      });
    };
    toBottom = function() {
      return $(".to-bottom").each(function() {
        var height;
        height = $(this).height();
        $(this).css({
          position: 'absolute',
          bottom: height
        });
        return $(this).fadeIn('slow');
      });
    };

    /*
    onYouTubeIframeAPIReady = ->
      $(window).load ->
        $(".youtube-bg-iframe").each (index) ->
          $(@).attr "id", "yt-" + index
          player = new YT.Player($(@).attr("id"),
            events:
              onReady: ->
                player.mute()
          )
    player.playVideo();
     */
    dateFormatter = function(date) {
      return date.toTimeString();
    };
    $('.bs-component [data-toggle="popover"]').popover();
    $('.bs-component [data-toggle="tooltip"]').tooltip();
    $(".inner-link").smoothScroll({
      offset: -96,
      speed: 800
    });
    $(".mobile-toggle").on('click', function() {
      return $("nav").toggleClass("open-nav");
    });
    $(".fullscreen-nav-toggle").on('click', function() {
      if (!$(".fullscreen-nav-container").hasClass("show-fullscreen-nav")) {
        $(".fullscreen-nav-container").addClass("show-fullscreen-nav");
        setTimeout((function() {
          return $(".fullscreen-nav-container").addClass("fade-fullscreen-nav");
        }), 100);
        return $(this).addClass("toggle-icon");
      } else {
        $(this).removeClass("toggle-icon");
        $(".fullscreen-nav-container").removeClass("fade-fullscreen-nav");
        return setTimeout((function() {
          return $(".fullscreen-nav-container").removeClass("show-fullscreen-nav");
        }), 500);
      }
    });
    $(".fullscreen-nav-container .menu li a").on('click', function() {
      $(".fullscreen-nav-toggle").removeClass("toggle-icon");
      $(".fullscreen-nav-container").removeClass("fade-fullscreen-nav");
      return setTimeout((function() {
        return $(".fullscreen-nav-container").removeClass("show-fullscreen-nav");
      }), 500);
    });
    if ($("header.title").size()) {
      $("header.title").css({
        height: Math.floor(_wh() / 3),
        'padding-bottom': '10px'
      });
    }

    /*
    $(".main-container").first().css
      height: Math.floor(($(window).height() / 3));
     */
    if ($(".top-bar").hasClass("overlay-bar") || $(".top-bar").hasClass("contained-bar")) {
      currentPad = parseInt($(".main-container").find(":first-child").css("padding-top"));
      newPad = currentPad + $(".top-bar").outerHeight();
      if (currentPad > 0) {
        $(".main-container").children(":first").css("padding-top", newPad);
      } else if ($(".main-container").find(":first").hasClass("hero-slider")) {
        height = parseInt($(".hero-slider .slides li:first-child").outerHeight());
        newHeight = height + $("nav").outerHeight();
        $(".hero-slider .slides li").css({
          "height": Math.floor(_wh() - $("#navbar_footer").height())
        });
      }
    }
    if ($(".hero-slider").size()) {
      $(".hero-slider").flexslider({
        animation: "fade"
      });
    }
    if ($(".image-slider").size()) {
      $(".image-slider").flexslider({
        animation: "slide"
      });
    }
    if ($(".image-slider").size()) {
      $(".testimonials-slider").flexslider({
        directionNav: false
      });
    }
    $(".slider-fullscreen .slides li").each(function() {
      return $(this).css({
        "height": _wh()
      });
    });
    $(".fullscreen-element").each(function() {
      return $(this).css({
        height: _wh()
      });
    });
    $(".selector-tabs li").on('click', function() {
      var activeTab;
      $(this).parent(".selector-tabs").children("li").removeClass("active");
      $(this).addClass("active");
      activeTab = $(this).index() + 1;
      $(this).closest(".feature-selector").find(".selector-content").children("li").removeClass("active");
      return $(this).closest(".feature-selector").find(".selector-content").children("li:nth-child(" + activeTab + ")").addClass("active");
    });
    $(".background-image-holder").each(function() {
      var imgSrc;
      imgSrc = $(this).children("img").attr("src");
      $(this).css({
        background: 'url("' + imgSrc + '")',
        "background-position": "50% 0%"
      });
      return $(this).children("img").hide();
    });
    $(".accordion li").on('click', function() {
      $(this).parent(".accordion").children("li").removeClass("active");
      return $(this).addClass("active");
    });
    $(".main-container section:first-child").addClass("first-child");
    $(".parallax-background").each(function() {
      if ($(this).closest("section").hasClass("first-child") && !$(this).closest("section").hasClass("slider-fullscreen")) {
        $(this).attr("data-top", prefix + "transform: translate3d(0px,0px, 0px)");
        return $(this).attr("data-top-bottom", prefix + "transform: translate3d(0px,200px, 0px)");
      } else {
        $(this).attr("data-bottom-top", prefix + "transform: translate3d(0px,-100px, 0px)");
        $(this).attr("data-center", prefix + "transform: translate3d(0px,0px, 0px)");
        return $(this).attr("data-top-bottom", prefix + "transform: translate3d(0px,100px, 0px)");
      }
    });
    if (!/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i.test(navigator.userAgent || navigator.vendor || window.opera)) {
      skrollr.init({
        forceHeight: false
      });
      $(".hover-background").each(function() {
        return $(this).mousemove(function(event) {
          $(this).find(".background-image-holder").css("transform", "translate(" + -event.pageX / 18 + "px," + -event.pageY / 18 + "px)");
          $(this).find(".layer-1").css("transform", "translate(" + -event.pageX / 9 + "px," + -event.pageY / 10 + "px)");
          return $(this).find(".layer-2").css("transform", "translate(" + -event.pageX / 5 + "px," + -event.pageY / 10 + "px)");
        });
      });
    }
    $(".map-holder").on('click', function() {
      return $(this).addClass("on");
    });
    $(".details-holder").each(function() {
      return $(this).css("height", $(this).width());
    });
    $(".details-holder").mouseenter(function() {
      return $(this).closest(".map-overlay").addClass("fade-overlay");
    }).mouseleave(function() {
      return $(this).closest(".map-overlay").removeClass("fade-overlay");
    });
    $(".countdown").each(function() {
      return $(this).countdown({
        until: new Date($(this).attr("data-date"))
      });
    });
    $("form.email-form").submit(function(e) {
      var error, originalError, thisForm;
      if (e.preventDefault) {
        e.preventDefault();
      } else {
        e.returnValue = false;
      }
      console.log("We have a submission...");
      thisForm = $(this).closest(".email-form");
      error = 0;
      originalError = thisForm.attr("original-error");
      if (typeof originalError !== typeof undefined && originalError !== false) {
        thisForm.find(".form-error").text(originalError);
      }
      $(thisForm).find(".validate-required").each(function() {
        if ($(this).val() === "") {
          $(this).addClass("field-error");
          return error = 1;
        } else {
          return $(this).removeClass("field-error");
        }
      });
      $(thisForm).find(".validate-email").each(function() {
        if (!/(.+)@(.+){2,}\.(.+){2,}/.test($(this).val())) {
          $(this).addClass("field-error");
          return error = 1;
        } else {
          return $(this).removeClass("field-error");
        }
      });
      if (error === 1) {
        $(this).closest(".email-form").find(".form-error").fadeIn(200);
      } else {
        jQuery.ajax({
          type: "POST",
          url: "mail/mail.php",
          data: thisForm.serialize(),
          success: function(response) {
            if ($.isNumeric(response)) {
              if (parseInt(response) > 0) {
                thisForm.find(".form-success").fadeIn(1000);
                thisForm.find(".form-error").fadeOut(1000);
                return setTimeout((function() {
                  return thisForm.find(".form-success").fadeOut(500);
                }), 5000);
              }
            } else {
              thisForm.find(".form-error").attr("original-error", thisForm.find(".form-error").text());
              thisForm.find(".form-error").text(response).fadeIn(1000);
              return thisForm.find(".form-success").fadeOut(1000);
            }
          }
        });
      }
      return false;
    });
    $(".expanding-ul li").on('click', function() {
      $(".expanding-ul li").removeClass("active");
      return $(this).addClass("active");
    });
    if ($(".projects-container").size()) {
      pro_container = document.querySelector(".projects-container");
      iso_projects = new Isotope(pro_container, {
        itemSelector: ".project",
        layoutMode: "fitRows"
      });
      $(".filters li").on('click', function() {
        var current, filterValue;
        current = $(this);
        current.siblings("li").removeClass("active");
        current.addClass("active");
        filterValue = current.attr("data-filter");
        return iso_projects.arrange({
          filter: filterValue
        });
      });
      if ($(".contained-features-wrapper").size()) {
        feat_container = document.querySelector(".contained-features-wrapper");
        iso_features = new Isotope(feat_container, {
          itemSelector: ".no-pad",
          layoutMode: "masonry",
          masonry: {
            gutter: 0
          }
        });
      }
    }

    /* INSTAGRAM
    
    if $(".instafeed").length
      jQuery.fn.spectragram.accessData =
         * demo.psicotecnico 
         * http://jelled.com/instagram/access-token
        accessToken: "1546828611.21b4c55.7e7130ad27054b5e827607a95f664b0b"
        clientID: "21b4c55189124209a7c7970c3925054b"
    
      $(".instafeed").each ->
        $(@).children("ul").spectragram "getUserFeed",
          query: $(@).attr("data-user-name")
     */

    /* TWEETS OLD
    if $("#tweets").length
      $("#tweets").flexslider
        directionNav: false
        controlNav: false
     */

    /* FORM 
    $("form.mail-list-signup").on "submit", ->
      iFrame = $(@).closest("section, header").find("iframe.mail-list-form")
      thisForm = $(@).closest(".mail-list-signup")
      userEmail = $(@).find(".signup-email-field").val()
      userFullName = $(@).find(".signup-name-field").val()
      userFirstName = $(@).find(".signup-first-name-field").val()
      userLastName = $(@).find(".signup-last-name-field").val()
      error = 0
      $(thisForm).find(".validate-required").each ->
        if $(@).val() is ""
          $(@).addClass "field-error"
          error = 1
        else
          $(@).removeClass "field-error"
    
      $(thisForm).find(".validate-email").each ->
        unless /(.+)@(.+){2,}\.(.+){2,}/.test($(@).val())
          $(@).addClass "field-error"
          error = 1
        else
          $(@).removeClass "field-error"
    
      if error is 0
        iFrame.contents().find("#mce-EMAIL, #fieldEmail").val userEmail
        iFrame.contents().find("#mce-LNAME, #fieldLastName").val userLastName
        iFrame.contents().find("#mce-FNAME, #fieldFirstName").val userFirstName
        iFrame.contents().find("#mce-FNAME, #fieldName").val userFullName
        iFrame.contents().find("form").attr("target", "_blank").submit()
      false
     */

    /* MASONRY
    if $(".blog-masonry-container").size()
      $(".blog-masonry-container").isotope
        itemSelector: ".blog-masonry-item"
        layoutMode: "masonry"
    
      $(".blog-filters li").on 'click', ->
        current = $(@)
        $(@).siblings("li").removeClass "active"
        $(@).addClass "active"
        filterValue = $(@).attr("data-filter")
        container = $(@).closest(".blog-masonry").find(".blog-masonry-container")
        container.isotope
          filter: filterValue
     */
    handleMYTweets = function(tweets) {
      var element, html, n, newhtml, x;
      x = tweets.length;
      n = 0;
      element = document.getElementById('last_tweets');
      html = '';
      newhtml = '';
      if ($("#last_tweets").size()) {
        while (n < x) {
          html += '<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4 "><div class="text-white">' + tweets[n] + '</div></div>';
          n++;
        }
        html += '';
        element.innerHTML = html;
        $('.user').fadeOut();
        $('.timePosted').each(function() {
          $(this).text(function(index, text) {
            var listOff, listOn;
            listOff = ['Posted', 'hours ago', 'minutes ago', 'days ago', ' on'];
            listOn = ['Publicado', 'h. atrás', 'min. atrás', 'días artás', ' el'];
            return replaceArray(text, listOff, listOn);
          });
          return $(this).addClass('label label-info').prependTo($(this).parent());
        });
        $('.tweet').each(function() {
          $(this).addClass('text-white');
          return $(this).find('a').each(function() {
            newhtml = $(this).html().replace(/(<([^>]+)>)/g, '');
            return $(this).css({
              "word-break": "break-all"
            }).html(newhtml);
          });
        });
        return $(".bottom-band").fadeIn();
      }
    };
    _last_tweets = function() {
      var last_tweets;
      last_tweets = {
        id: "251234664017174528",
        domId: "",
        maxTweets: 3,
        enableLinks: true,
        showUser: true,
        showTime: true,
        dateFunction: "",
        showRetweet: false,
        customCallback: handleMYTweets,
        showInteraction: false
      };
      return twitterFetcher.fetch(last_tweets);
    };
    _snap_it('#logo');
    _snap_it('#logo-author');
    _snap_it('#smiley');
    _init();
    return _last_tweets();
  });

}).call(this);


/*
 * http://louisremi.github.io/jquery-smartresize/demo/index.html
 * debouncedresize: special jQuery event that happens once after a window resize
 * 
 *   * latest version and complete README available on Github:
 *   * https://github.com/louisremi/jquery-smartresize/blob/master/jquery.debouncedresize.js
 *   *
 *   * Copyright 2011 @louis_remi
 *   * Licensed under the MIT license.
 *  execAsap ? dispatch() : resizeTimeout = setTimeout(dispatch, $special.threshold);
 */

(function() {
  (function($, window, document) {
    var $event, $special, resizeTimeout;
    $event = $.event;
    $special = void 0;
    resizeTimeout = void 0;
    return $special = $event.special.debouncedresize = {
      setup: function() {
        return $(this).on('resize', $special.handler);
      },
      teardown: function() {
        return $(this).off('resize', $special.handler);
      },
      handler: function(event, execAsap) {
        var args, context, dispatch;
        context = this;
        args = arguments;
        dispatch = function() {
          event.type = 'debouncedresize';
          return $event.dispatch.apply(context, args);
        };
        if (resizeTimeout) {
          clearTimeout(resizeTimeout);
        }
        if (execAsap) {
          return dispatch();
        } else {
          return resizeTimeout = setTimeout(dispatch, $special.threshold);
        }
      },
      threshold: 100
    };
  })(jQuery, window, document);

}).call(this);


/*
 * 
 * http://paulirish.com/2011/requestanimationframe-for-smart-animating/
 * http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating

 * requestAnimationFrame polyfill by Erik Möller
 * fixes from Paul Irish and Tino Zijdel
 *
 * @refactoring to CofeeScript by Alfredo Llanos <alfredo@tallerdelsoho.es> || @biojazzard
 */

(function() {
  ((function(_this) {
    return function() {
      var lastTime, vendor, vendors, _i, _len;
      lastTime = 0;
      vendors = ['ms', 'moz', 'webkit', 'o'];
      _this.raf = function(_v) {
        window.requestAnimationFrame = window[_v + 'RequestAnimationFrame'];
        return window.cancelAnimationFrame = window[_v + 'cancelAnimationFrame'] || window[_v + 'cancelAnimationFrame'];
      };
      for (_i = 0, _len = vendors.length; _i < _len; _i++) {
        vendor = vendors[_i];
        _this.raf(vendor);
      }
      if (!window.requestAnimationFrame) {
        window.requestAnimationFrame = function(callback, element) {
          var currTime, id, timeToCall;
          currTime = Date();
          timeToCall = Math.max(0, 16 - (currTime - lastTime));
          id = window.setTimeout(function() {
            callback(currTime + timeToCall);
          }, timeToCall);
          lastTime = currTime + timeToCall;
          return id;
        };
      }
      if (!window.cancelAnimationFrame) {
        return window.cancelAnimationFrame = function(id) {
          clearTimeout(id);
        };
      }
    };
  })(this))();

}).call(this);

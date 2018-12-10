(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
(function (global){
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
      // Save the context
      context = this;
      args = arguments;
      dispatch = function() {
        // set correct event type
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
    threshold: 22
  };
})(global.jQuery, window, document);

}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{}],2:[function(require,module,exports){
// ==========================================================================
//  1unes | NOV 2018
// ==========================================================================
var debouncedresize;

debouncedresize = require('./_debouncedresize');

$(document).ready(function() {
  /*
   * Dropzone
   */
  /*
   * zoom
   */
  var DZ, content, enableDropZone, init, markedIt, myDropzone, reDraw, reWrite, zoom;
  enableDropZone = false;
  markedIt = function(sel, text) {
    document.querySelector(sel).innerHTML = marked(text);
  };
  //var cont = document.querySelector(sel).innerHTML;
  //document.querySelector(sel).innerHTML = Autolinker.link( cont );
  reDraw = function(contentObj) {
    $.each(contentObj, function(cla, txt) {
      $('.' + cla).text(txt);
    });
    $('[contenteditable]').each(function() {
      $(this).attr('id', 'lunes_' + Math.floor(Math.random() * 300));
    });
  };
  zoom = function() {
    var bh, sh, z;
    sh = $('.sheet').outerHeight();
    bh = $('body').outerHeight();
    z = (bh / sh) * 100 - 10;
    if (z < 100) {
      return $('html').css({
        zoom: z + '%'
      });
    }
  };
  init = "# Hola <span class=\"name\" contenteditable>####</span>\n\n## Arrastra un archivito <span class=\"name\" contenteditable>####</span>!!!.\n\n### Encabezado 3\n\n#### Encabezado 4\n\n##### Encabezado 5\n\n###### Encabezado 6";
  reWrite = function() {
    var $this, wichClass;
    $this = $(this);
    console.log('BLUR $this', $this[0].className);
    wichClass = '.' + $this[0].className;
    if ($this.data('before') !== $this.text()) {
      $this.data('before', $this.text());
      $this.trigger('change');
      $.each($(wichClass), function(key, value) {
        if ($(value).attr('id') !== $this.attr('id')) {
          $(value).text($this.text());
        }
      });
    }
    return $this;
  };
  content = {
    title: 'Cuenta de correo para ',
    company: 'Mi Empresa',
    domain: 'domain.com',
    name: 'Pepito',
    user: 'user',
    pass: '1234',
    cif: 'E95678345',
    pop: '2rdq-6fhl.accessdomain.com',
    smtp: '2rdq-6fhl.accessdomain.com',
    address: 'Mazarredo Zumarkalea, 31, 4º B, 48009 Bilbao',
    mod: '6 de Diciembre de 2018'
  };
  
  // Generate Welcome

  //markedIt '.contact', init

  //reDraw content
  /*
  $(window).on 'debouncedresize.zoom', ->
  setTimeout ->
  zoom()
  , 333 

  $(window).trigger 'debouncedresize.zoom'
  */
  if (enableDropZone) {
    $('body').on('focus', '[contenteditable]', function() {
      var $this;
      $this = $(this);
      $this.data('before', $this.text());
      return $this;
    }).on('blur keyup paste input', '[contenteditable]', reWrite);
    DZ = window.Dropzone;
    myDropzone = new Dropzone('body', {
      url: './'
    });
    myDropzone.on('addedfile', function(file) {
      var reader;
      // Hookup the start button
      //console.log(file[0]);
      //var file = document.getElementById("fileForUpload").files[0];
      if (file) {
        reader = new FileReader;
        reader.readAsText(file, 'UTF-8');
        reader.onload = function(evt) {
          var md;
          md = evt.target.result;
          markedIt('article', md);
          reDraw(content);
          $('body').on('focus', '[contenteditable]', function() {
            var $this;
            $this = $(this);
            $this.data('before', $this.text());
            console.log('FOCUS $this', $this);
            return $this;
          }).on('blur keyup paste input', '[contenteditable]', reWrite);
        };
        reader.onerror = function(evt) {
          var md;
          md = 'Error al cargar el archivo.';
          markedIt('article', md);
        };
      }
    });
    /*
     * Keymaster
     */
    key('f', function() {
      if ($('.dz-preview').length > 0) {
        $('.dz-preview').addClass('opened');
        $('.sheet').addClass('opened');
      }
      $('.dz-preview').on('click', function() {
        $(this).removeClass('opened');
        $('.sheet').removeClass('opened');
      });
    });
  }
});

},{"./_debouncedresize":1}]},{},[2]);

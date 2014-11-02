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

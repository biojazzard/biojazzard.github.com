$ = require('jquery')
domready = require 'domready'
FastClick = require('fastclick')
bootstrap = require('bootstrap')
smoothScroll = require('smoothScroll')
scrollReveal = require('scrollReveal')
flexslider = require('flexslider')
Skrollr = require('skrollr')
Isotope = require('isotope')
Snap = require('snap')

#eventie = require('eventie')
#docReady = require('doc-ready')
#EventEmitter = require('eventEmitter')

# On DOM ready 
domready ->

  isFirefox = typeof InstallTrigger isnt "undefined"
  isIE = false or !!document.documentMode
  isChrome = !!window.chrome
  isSafari = Object::toString.call(window.HTMLElement).indexOf("Constructor") > 0
  prefix = undefined
  
  if isFirefox
    prefix = "-moz-"
  else if isIE
    prefix = ""
  else prefix = "-webkit-" if isChrome or isSafari

  #pBottom = _th "#navbar_footer"

  #pTop = _th ".top-bar"

  console.log "We are here---->"

  # FUNCTIONS 

  replaceArray = (replaceString, find, replace) ->
    i = 0
    while i < find.length
      replaceString = replaceString.replace(find[i], replace[i])
      i++
    replaceString

  _eq_heights = ($item) ->
    h = 0
    $item.each (index, val) ->
      if $(@).height() >= h
        h = $(@).height()
    $item.css
      height: Math.floor h
      display: 'block'

  _wh = ->
    Math.floor $(window).height()

  _ww = ->
    Math.floor $(window).width()

  _th = (selector) ->
    height = Math.floor $(selector).height()
    console.log 'height' + selector + height
    height

  _tw = (selector) ->
    width = Math.floor $(selector).width()
    console.log 'width' + selector + width
    width

  _as = (upSelector = '.top-bar', downSelector = '.navbar-fixed-bottom') ->
    Math.floor _wh() - (_th(upSelector) + _th(downSelector))

  scrollTop = ->
    (if (window.pageYOffset isnt `undefined`) then window.pageYOffset else (document.documentElement or document.body.parentNode or document.body).scrollTop)

  _init = () ->

    unless (/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent or navigator.vendor or window.opera)
      $("body").addClass "no-pointer"
    else
      $("body").addClass "pointer"

    new FastClick(document.body)

    window.scrollTo(0, 0)

    $(".loader").css
      opacity: 0
      
    setTimeout ->
      $(".loader").hide()
    , 666

    # ALIGNS

    $(window).on 'debouncedresize.general', ->
      console.log "general----------------------------------"
      alignPage()
      alignVertical()
      alignBottom()
      toBottom()

      # hero
      if not $("nav").hasClass("overlay-bar") and not $("nav").hasClass("contained-bar")
        $(".main-container").first().css
          "margin-top": $("nav").outerHeight()
      # subnav
      $(".subnav-fullwidth").each ->
        $(@).css
          width: $(".container").width()
        offset = $(@).closest(".has-dropdown").offset()
        offset = offset.left
        containerOffset = _ww() - $(".container").outerWidth()
        containerOffset = containerOffset / 2
        offset = offset - containerOffset - 15
        $(@).css
          left: -offset

      if $('#features-strip')
        if _ww() >= 1024
          $('.feature-box').find('.btn').css
            position: 'absolute'
            bottom: '10px'
        else
          if _wh() >= _ww()
            $('.feature-box').find('.btn').css
              position: 'relative'
              bottom: 0
          else
            $('.feature-box').find('.btn').css
              position: 'relative'
              bottom: 0   

      if $('#children-boxes').size()
        if _ww() >= 1024
          $('#children-boxes').css
            'padding-top': _th('.top-bar')
            height: Math.floor ( _wh() - _th('.navbar-fixed-bottom') ) * 0.66666
          $(".features-strip").css
            height: Math.floor ( _wh() - _th('.navbar-fixed-bottom') ) * 0.33333
          $(".features-strip").find('.feature-box').css
            'min-height': Math.floor ( _wh() - _th('.navbar-fixed-bottom') ) * 0.33333
            display: 'block'
          $('.pricing-table').css
            height: $('#children-boxes').height() - 10
            display: 'block'
        else
          if _wh() >= _ww()
            $('#children-boxes').css
              'padding-top': _th('.top-bar') + 10
            $(".features-strip").find('.feature-box').css
              'min-height': 0
              display: 'block'
            $('.pricing-table').css
              height: 'auto'
              'min-height': 0
              display: 'block'
          else 
            $('#children-boxes').css
              'padding-top': _th('.top-bar') + 10
            $('.features-strip').find('.feature-box').css
              'min-height': 0
              display: 'block'

          _eq_heights $('.pricing-table')

      if $('.map-holder').size()
        if _ww() >= 992
          $('.map-holder').css
            height: _as()
          $('.map-holder').find('iframe').css
            height: '100%'
            width: '100%'
          $('#mapa').find('.feature-box').css
            'min-height': _as()
            display: 'block'

        else 
          if _wh() >= _ww()
            $('.map-holder').css
              height: Math.round _as() * 0.666666
            $('.map-holder').find('iframe').css
              height: _as() * 0.666666
              width: '100%'
            $('#mapa').find('.feature-box').css
              'min-height': Math.round _as() * 0.333333
              display: 'block'
          else
            $('.map-holder').css
              height: _as() * 0.666666
            $('.map-holder').find('iframe').css
              height: Math.round _as() * 0.666666
              width: '100%'
            $('#mapa').find('.feature-box').css
              'min-height': Math.round _as() * 0.333333
              display: 'block'

      $("#to-contact").smoothScroll
          offset: -_th(".top-bar")
          #offset: -Math.floor $(".top-bar").height()
          speed: 400

      $("#to-blog").smoothScroll
          offset: -_th(".top-bar")
          #offset: -Math.floor $(".top-bar").height()
          speed: 400

    setTimeout ->
      $(window).trigger 'debouncedresize.general'
    , 888

    # SCROLLS
    $(window).scroll ->
      # MAP
      if $(".map-holder").hasClass("on")
        $(".map-holder").removeClass "on"
      # STICKY
      if scrollTop() > 180 and not $(".mobile-toggle").is(":visible")
        $(".top-bar").addClass "nav-sticky"
      else
        $(".top-bar").removeClass "nav-sticky"

    # SIDEBAR TOGGLE

    $(".offscreen-toggle").on 'click', ->
      $(".main-container").toggleClass "reveal-nav"
      $(".offscreen-container").toggleClass "reveal-nav"
      $(".offscreen-menu .container").toggleClass "reveal-nav"

    $(".main-container").on 'click', ->
      if $(@).hasClass("reveal-nav")
        $(".main-container").toggleClass "reveal-nav"
        $(".offscreen-container").toggleClass "reveal-nav"
        $(".offscreen-menu .container").toggleClass "reveal-nav"

    $('.footer-container').css
      'margin-bottom': Math.floor $("#navbar_footer").height()

  _snap_it = (id) ->

    if $(id).size()

      s = undefined
      sData = $(id).attr('data-src')

      # Now lets load external SVG file:
      Snap.load sData, (loadedFragment) ->

        s = Snap id
        s.append loadedFragment

  _snap_logo = () ->

    if $("#logo").size()

      s = undefined
      sData = $('#logo').attr('data-src')

      # Now lets load external SVG file:
      Snap.load sData, (loadedFragment) ->

        s = Snap("#logo")
        s.append loadedFragment

  _snap = () ->

    $('.icon-img').each ->

      lf = undefined
      s = undefined
      sdata = undefined

      $name = $(@).attr('data-name')  

      $sdata = $(@).attr('data-src') 

      # Now lets load external SVG file:
      Snap.load $sdata, (loadedFragment) ->

        s = Snap("#snap-" + $name)
        s.append loadedFragment

  _pointLess = () ->

    $('.point').each ->
      $(@).parent().css(
        display: 'block'
        'background-image': 'url(' + @src + ')'
        'background-size': 'cover'
        'background-position': '50% 50%'
        'margin': '0 auto'
        #height: '100%'
        #width: '100%'
        #height: $(@).parent().height()
      ).addClass 'processed'
      $(@).css(
        display: 'none'
        #height: '100%'
        #width: '100%'
      ).attr 'alt', ''
  
  # EXTRA 
  handleTweets = (tweets) ->
    x = tweets.length
    n = 0
    element = document.getElementById("tweets")
    html = "<ul class=\"slides\">"
    while n < x
      html += "<li>" + tweets[n] + "</li>"
      n++
    html += "</ul>"
    element.innerHTML = html

  alignPage = ->
    $(".align-page").each ->
      height = $(@).height()
      parentHeight = $(@).parent().height()
      padAmount = (parentHeight / 2) - (height / 2)
      $(@).css
        "padding-top": _th('.top-bar') + (padAmount / 2)
      $(@).fadeIn('slow')

  alignVertical = ->
    $(".align-vertical").each ->
      height = $(@).height()
      parentHeight = $(@).parent().height()
      padAmount = (parentHeight / 2) - (height / 2)
      $(@).css
        "padding-top": padAmount
      $(@).fadeIn('slow')


  alignBottom = ->
    $(".align-bottom").each ->
      height = $(@).height()
      parentHeight = $(@).parent().height()
      padAmount = (parentHeight) - (height)
      $(@).css
        "padding-top": padAmount
      $(@).fadeIn('slow')

  toBottom = ->
    $(".to-bottom").each ->
      height = $(@).height()
      $(@).css
        position: 'absolute'
        bottom: height
      $(@).fadeIn('slow')

  # Youtube Background Handling
  ###
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
  ###
  
  # For advanced example which allows you to customize how tweet time is
  #    formatted you simply define a function which takes a JavaScript date as a
  #    parameter and returns a string! 

  dateFormatter = (date) ->
    date.toTimeString()
  
  $('.bs-component [data-toggle="popover"]').popover();
  $('.bs-component [data-toggle="tooltip"]').tooltip();

  $(".inner-link").smoothScroll
    offset: -96
    speed: 800

  $(".mobile-toggle").on 'click', ->
    $("nav").toggleClass "open-nav"

  $(".fullscreen-nav-toggle").on 'click', ->
    unless $(".fullscreen-nav-container").hasClass("show-fullscreen-nav")
      $(".fullscreen-nav-container").addClass "show-fullscreen-nav"
      setTimeout (->
        $(".fullscreen-nav-container").addClass "fade-fullscreen-nav"
      ), 100
      $(@).addClass "toggle-icon"
    else
      $(@).removeClass "toggle-icon"
      $(".fullscreen-nav-container").removeClass "fade-fullscreen-nav"
      setTimeout (->
        $(".fullscreen-nav-container").removeClass "show-fullscreen-nav"
      ), 500

  $(".fullscreen-nav-container .menu li a").on 'click', ->
    $(".fullscreen-nav-toggle").removeClass "toggle-icon"
    $(".fullscreen-nav-container").removeClass "fade-fullscreen-nav"
    setTimeout (->
      $(".fullscreen-nav-container").removeClass "show-fullscreen-nav"
    ), 500

  if $("header.title").size()
    $("header.title").css
      height: Math.floor((_wh() / 3))
      'padding-bottom': '10px'

  ###
  $(".main-container").first().css
    height: Math.floor(($(window).height() / 3));
  ###

  if $(".top-bar").hasClass("overlay-bar") or $(".top-bar").hasClass("contained-bar")
    currentPad = parseInt($(".main-container").find(":first-child").css("padding-top"))
    newPad = currentPad + $(".top-bar").outerHeight()
    if currentPad > 0
      $(".main-container").children(":first").css "padding-top", newPad
    else if $(".main-container").find(":first").hasClass("hero-slider")
      height = parseInt($(".hero-slider .slides li:first-child").outerHeight())
      newHeight = height + $("nav").outerHeight()
      $(".hero-slider .slides li").css
        "height": Math.floor( _wh() - $("#navbar_footer").height())

  # FLEXSLIDER HERO
  if $(".hero-slider").size()
    $(".hero-slider").flexslider
      animation: "fade"
  
  # FLEXSLIDER IMAGES
  if $(".image-slider").size()
    $(".image-slider").flexslider
      animation: "slide"

  # FLEXSLIDER TESTTIMONIALS
  if $(".image-slider").size()
    $(".testimonials-slider").flexslider
      directionNav: false

  # FLEXSLIDER RESIZES
  $(".slider-fullscreen .slides li").each ->
    $(@).css
      "height": _wh()

  $(".fullscreen-element").each ->
    $(@).css
      height: _wh()

  $(".selector-tabs li").on 'click', ->
    $(@).parent(".selector-tabs").children("li").removeClass "active"
    $(@).addClass "active"
    activeTab = $(@).index() + 1
    $(@).closest(".feature-selector").find(".selector-content").children("li").removeClass "active"
    $(@).closest(".feature-selector").find(".selector-content").children("li:nth-child(" + activeTab + ")").addClass "active"

  $(".background-image-holder").each ->
    imgSrc = $(@).children("img").attr("src")
    $(@).css
      background: 'url("' + imgSrc + '")'
      "background-position": "50% 0%"
    $(@).children("img").hide()

  $(".accordion li").on 'click', ->
    $(@).parent(".accordion").children("li").removeClass "active"
    $(@).addClass "active"

  $(".main-container section:first-child").addClass "first-child"
  $(".parallax-background").each ->
    #console.log @
    if $(@).closest("section").hasClass("first-child") and not $(@).closest("section").hasClass("slider-fullscreen")
      $(@).attr "data-top", prefix + "transform: translate3d(0px,0px, 0px)"
      $(@).attr "data-top-bottom", prefix + "transform: translate3d(0px,200px, 0px)"
    else
      $(@).attr "data-bottom-top", prefix + "transform: translate3d(0px,-100px, 0px)"
      $(@).attr "data-center", prefix + "transform: translate3d(0px,0px, 0px)"
      $(@).attr "data-top-bottom", prefix + "transform: translate3d(0px,100px, 0px)"

  unless (/Android|iPhone|iPad|iPod|BlackBerry|Windows Phone/i).test(navigator.userAgent or navigator.vendor or window.opera)
    
    skrollr.init 
      forceHeight: false

    $(".hover-background").each ->
      $(@).mousemove (event) ->
        $(@).find(".background-image-holder").css "transform", "translate(" + -event.pageX / 18 + "px," + -event.pageY / 18 + "px)"
        $(@).find(".layer-1").css "transform", "translate(" + -event.pageX / 9 + "px," + -event.pageY / 10 + "px)"
        $(@).find(".layer-2").css "transform", "translate(" + -event.pageX / 5 + "px," + -event.pageY / 10 + "px)"

  $(".map-holder").on 'click', ->
    $(@).addClass "on"

  $(".details-holder").each ->
    $(@).css "height", $(@).width()

  $(".details-holder").mouseenter(->
    $(@).closest(".map-overlay").addClass "fade-overlay"
  ).mouseleave ->
    $(@).closest(".map-overlay").removeClass "fade-overlay"

  $(".countdown").each ->
    $(@).countdown until: new Date($(@).attr("data-date"))

  $("form.email-form").submit (e) ->
    if e.preventDefault
      e.preventDefault()
    else
      e.returnValue = false
    console.log "We have a submission..."
    thisForm = $(@).closest(".email-form")
    error = 0
    originalError = thisForm.attr("original-error")
    thisForm.find(".form-error").text originalError  if typeof originalError isnt typeof `undefined` and originalError isnt false
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

    if error is 1
      $(@).closest(".email-form").find(".form-error").fadeIn 200
    else
      jQuery.ajax
        type: "POST"
        url: "mail/mail.php"
        data: thisForm.serialize()
        success: (response) ->
          if $.isNumeric(response)
            if parseInt(response) > 0
              thisForm.find(".form-success").fadeIn 1000
              thisForm.find(".form-error").fadeOut 1000
              setTimeout (->
                thisForm.find(".form-success").fadeOut 500
              ), 5000
          else
            thisForm.find(".form-error").attr "original-error", thisForm.find(".form-error").text()
            thisForm.find(".form-error").text(response).fadeIn 1000
            thisForm.find(".form-success").fadeOut 1000

    false

  $(".expanding-ul li").on 'click', ->
    $(".expanding-ul li").removeClass "active"
    $(@).addClass "active"

  # ISOTOPE
  
  if $(".projects-container").size()
    # Vanilla JS
    pro_container = document.querySelector(".projects-container")
    iso_projects = new Isotope pro_container,
      # options...
      itemSelector: ".project"
      layoutMode: "fitRows"
  
    $(".filters li").on 'click', ->
      current = $(@)
      current.siblings("li").removeClass "active"
      current.addClass "active"
      filterValue = current.attr("data-filter")
      #container = current.closest(".projects-wrapper").find(".projects-container")
      #container.isotope filter: filterValue
      iso_projects.arrange
        filter: filterValue

    if $(".contained-features-wrapper").size()
      feat_container = document.querySelector(".contained-features-wrapper")
      iso_features = new Isotope feat_container,
        # options...
        itemSelector: ".no-pad"
        layoutMode: "masonry"
        masonry:
          gutter: 0

  ### INSTAGRAM

  if $(".instafeed").length
    jQuery.fn.spectragram.accessData =
      # demo.psicotecnico 
      # http://jelled.com/instagram/access-token
      accessToken: "1546828611.21b4c55.7e7130ad27054b5e827607a95f664b0b"
      clientID: "21b4c55189124209a7c7970c3925054b"

    $(".instafeed").each ->
      $(@).children("ul").spectragram "getUserFeed",
        query: $(@).attr("data-user-name")

  ###

  ### TWEETS OLD
  if $("#tweets").length
    $("#tweets").flexslider
      directionNav: false
      controlNav: false

  ###

  ### FORM 
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

  ###

  ### MASONRY
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
  ###

  # TWEETS

  handleMYTweets = (tweets) ->
    x = tweets.length
    n = 0
    element = document.getElementById('last_tweets')
    html = ''
    newhtml = ''
    if $("#last_tweets").size()
      while n < x
        html += '<div class="col-xs-12 col-sm-4 col-md-4 col-lg-4 "><div class="text-white">' + tweets[n] + '</div></div>'
        n++
      html += ''
      element.innerHTML = html
      $('.user').fadeOut()
      $('.timePosted').each ->
        $(@).text (index, text) ->
          listOff = ['Posted', 'hours ago', 'minutes ago', 'days ago', ' on']
          listOn = ['Publicado', 'h. atrás', 'min. atrás', 'días artás', ' el']
          replaceArray(text, listOff, listOn);
        $(@).addClass('label label-info').prependTo $(@).parent()

      $('.tweet').each ->
        $(@).addClass 'text-white'
        $(@).find('a').each ->
          newhtml = $(@).html().replace(/(<([^>]+)>)/g, '')
          $(@).css
            "word-break": "break-all"
          .html newhtml

      $(".bottom-band").fadeIn()

  _last_tweets = () ->

    last_tweets =
      id: "251234664017174528"
      domId: ""
      maxTweets: 3
      enableLinks: true
      showUser: true
      showTime: true
      dateFunction: ""
      showRetweet: false
      customCallback: handleMYTweets
      showInteraction: false

    twitterFetcher.fetch last_tweets

  # INIT ALL

  _snap_it '#logo'
  _snap_it '#logo-author'
  _snap_it '#smiley'
  _init()
  _last_tweets()

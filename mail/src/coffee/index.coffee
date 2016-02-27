# By Alfredo Llanos | @biojazzard

(($, window, document, undefined_) ->

  ###
  # Media source root URL
  #
  ###
  console.log 'init!'

  _drawImg = (str)->
    #src = $('#img-preview').attr('src')
    if str == '#' || str == ''
      console.log 'yes src'
      $.ajax
        type: 'GET'
        url: 'html.php'
        data:
          default: true
        dataType: 'text'
      .done (data)->
        htmlResp = $.parseHTML(data)
        $domResp = $(htmlResp)
        if $domResp
          $('#preview').html $domResp

    else
      newstr = $('#form-url').val()
      #$('#img-preview').attr('src', newstr)
      #$('#preview').html $domResp
      $('#preview').html '<img id="img-preview" class="img-responsive" src="' + newstr + '">'

  _drawImg $('#img-preview').attr('src')

  $('textarea').val($('textarea').attr('data-placeholder'))

  $('#response-wait').on 'click', ()->
    $(@).addClass 'hiddem'

  ###
  #
  ###

  errEmail = 1;
  errUrl = 0;
  errPass = 1;
  errSubject = 0;

  validations =
    email: [
      /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/,
      'Email inválido'
      ]
    url: [
      /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/,
      'URL malformada.'
      ]
    pass: [
      /^[a-zA-Z0-9!@#$%^&*]{6,16}$/,
      'Password requerido'
      ]
    subject: [
      /^[-\sa-zA-Z]+$/,
      'Texto requerido'
      ]

  ###
  # Subject
  ###

  $('input[type="text"]').on 'blur', ()->

    testVal = $(@).val()

    # Set the regular expression to validate the url
    validation = new RegExp(validations['subject'][0])
    # validate the email value against the regular expression
    if !validation.test(testVal)
      # If the validation fails then we show the custom error message
      $(@).parent().removeClass 'has-success'
      $(@).parent().addClass 'has-warning'
      errSubject = 1
      return false
    else
      # This is really important. If the validation is successful you need to reset the custom error message
      $(@).parent().removeClass 'has-warning'
      $(@).parent().addClass 'has-success'
      #$('#subject-bind').html testVal
      errSubject = 0

  ###
  # Email
  ###

  $('input[type="email"]').on 'blur', ()->
    testVal = $(@).val()
    # Set the regular expression to validate the email
    validation = new RegExp(validations['email'][0])
    # validate the email value against the regular expression
    if !validation.test(testVal)
      # If the validation fails then we show the custom error message
      $(@).parent().removeClass 'has-success'
      $(@).parent().addClass 'has-warning'
      errEmail = 1
      return false
    else
      # This is really important. If the validation is successful you need to reset the custom error message
      $(@).parent().removeClass 'has-warning'
      $(@).parent().addClass 'has-success'
      #$('#email-bind').html testVal
      errEmail = 0
    return

  $('input[type="url"]').on 'blur', ()->

    testVal = $(@).val()

    # Set the regular expression to validate the url
    validation = new RegExp(validations['url'][0])
    # validate the email value against the regular expression
    if !validation.test(testVal)
      # If the validation fails then we show the custom error message
      $(@).parent().removeClass 'has-success'
      $(@).parent().addClass 'has-warning'
      errUrl = 0 # No inhabilita
      return false
    else
      # This is really important. If the validation is successful you need to reset the custom error message
      $(@).parent().removeClass 'has-warning'
      $(@).parent().addClass 'has-success'
      errUrl = 0

    _drawImg testVal

  $('input[type="password"]').on 'blur', ()->

    testVal = $(@).val()

    # Set the regular expression to validate the url
    validation = new RegExp(validations['pass'][0])
    # validate the email value against the regular expression
    if !validation.test(testVal)
      # If the validation fails then we show the custom error message
      $(@).parent().removeClass 'has-success'
      $(@).parent().addClass 'has-warning'
      errPass = 1
      return false
    else
      # This is really important. If the validation is successful you need to reset the custom error message
      $(@).parent().removeClass 'has-warning'
      $(@).parent().addClass 'has-success'
      errPass = 0

  $('textarea').on 'focus', ()->
    if $(@).val() == $(@).attr('data-placeholder')
      $(@).val('')

  $('textarea').on 'blur', ()->

    testVal = $(@).val()
    ###
    if testVal == ''
      $(@).val($(@).attr('data-placeholder'))
    ###

    console.log 'testVal', testVal

    if testVal.length == 0
      # If the validation fails then we show the custom error message
      $(@).parent().removeClass 'has-success'
      $(@).parent().addClass 'has-warning'
      errSubject = 0 #NO Obliga
      return false
    else
      # This is really important. If the validation is successful you need to reset the custom error message
      $(@).parent().removeClass 'has-warning'
      $(@).parent().addClass 'has-success'
      #$('#body-bind').html testVal
      errSubject = 0

  myBtnValidation = setInterval ()->
    console.log 'allErrors', errEmail + errUrl + errPass
    if errEmail + errUrl + errPass > 0
      $('.btn-mailto').addClass('disabled btn-success').removeClass('btn-warning')
    else
      $('.btn-mailto').removeClass('disabled btn-success').addClass('btn-warning')
  , 1200

  $('.btn-mailto').on 'click', (e)->
    #e.preventDefault()
    clearInterval(myBtnValidation)
    console.log 'click!'
    email = $('#form-email').val()
    pass = $('#form-pass').val()
    url = $('#form-url').val()
    subject = $('#form-subject').val()
    body = $('#form-body').val()
    $('#mailer-form').css
      opacity: 0.6
    $('#response-wait').removeClass 'hidden'
    $msg = $('#response-holder')

    $.ajax
      type: 'POST'
      url: 'html.php'
      data:
        subject: subject
        email: email
        url: url
        body: body
        password: pass
      dataType: 'text'
    .done (data)->
      htmlResp = $.parseHTML(data)
      $domResp = $(htmlResp)
      if $domResp
        $domResp.appendTo $msg
        $('#mailer-form').css
          opacity: 1
        $('#response-wait').addClass 'hidden'
    .fail (data)->
      htmlResp = $.parseHTML(data)
      $domResp = $(htmlResp)
      if $domResp
        $domResp.appendTo $msg
        $('#mailer-form').css
          opacity: 1
        $('#response-wait').addClass 'hidden'
  ###
  # misc
  ###

  $(window).resize ->
    console.log 'resized'
    return

) jQuery, window, document

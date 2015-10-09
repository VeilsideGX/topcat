$(document).on 'ready page:load', ->

  $(".back_link").click (event) ->
    $(".first-step").show()
    $(".second-step").hide()

  $("#continue").click (event) ->
    $("#new_user").validate()

  $(".user-type").click (event) ->
    user_type = $(this).data("value")
    $.ajax(
      type: "GET"
      url: "/registrations/user_details"
      data:
        user_type: user_type
    ).done (msg) ->
      $(".third-step").html msg.html
      $(".second-step").hide()
      $(".third-step").show()
      $('.btn-login-submit').val("Create Account")
      $('.btn-login-submit').show()
      $("#user_role").val(user_type)

  $("#new_user").validate
    rules:
      "user[email]":
        required: true
        email: true
        remote:
          url: "/check_email"
          type: "get"
          data:
            email: ->
              $("#email").val()

      "user[password]":
        required: true
        minlength: 8
      agree: "required"

    messages:
      "user[password]":
        required: "Please provide a password"
        minlength: "Your password must be at least 8 characters long"
      "user[email]":
        required: "Please enter email"
        email: "Please enter a valid email address"
        remote: "Email already exist"
      agree: "Please accept our policy"

    submitHandler: (form) ->
      if $(".third-step").is(':hidden')
        $(".first-step").hide()
        $(".second-step").show()
        $('.btn-login-submit').hide()
      else
        form.submit()
   

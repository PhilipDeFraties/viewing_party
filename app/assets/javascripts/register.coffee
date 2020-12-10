$(document).on "click", "#register-link", (e) ->
  e.preventDefault()
  $("#register-form").fadeToggle()
  $('#login-link').toggle()
  $('#register-link').toggle()
  $('#separator').toggle()
  $('#greeting').toggle()
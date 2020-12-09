$(document).on "click", "#login-link", (e) ->
  e.preventDefault()
  $("#login-form").fadeToggle()
  $('#login-link').toggle()
  $('#register-link').toggle()
  $('#separator').toggle()
  $('#greeting').toggle()
$(document).on('turbolinks:load', function() {
  $("#collapse-options").height(0)
  $("#collapse-login-options").height(0)
  $(".dropdown").on('mouseover', function(e) {
    e.preventDefault();
    $(".collapse").height(0)
    $($(this)[0].dataset.target.toString()).height('auto')
  })
  $(".dropdown").on('focusout', function(e) {
    e.preventDefault();
    $(".collapse").height(0)
  })
})

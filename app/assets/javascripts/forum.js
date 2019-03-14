$(document).ready(function () {
  $( 'p:empty' ).remove();

  $("form").keypress(function(e) {
    //Enter key
    if (e.which == 13 && $(this).find('textarea').val() == '') {
      return false;
    }
  });

  var textarea = $('#forum_post_form_wrapper').find('#forum_post_body')
  var submit_button = $('#forum_post_form_wrapper').find('button[type="submit"]')

  submit_button.prop('disabled', true);

  textarea.on("keyup", function() {

    if(textarea.val() == ''){
      submit_button.prop('disabled' , true);
    } else {
      submit_button.prop('disabled' , false);
    }
  })
})
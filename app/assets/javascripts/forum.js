$(document).ready(function () {
  $('p:empty').remove();

  $("form").keypress(function (e) {
    //Enter key
    if (e.which == 13 && $(this).find('textarea').val() == '') {
      return false;
    }
  });

  $("[data-behavior~=comment-form]").each(function () {
    var textarea = $(this).find('#forum_post_body')
    if (textarea.length) {
      var submit_button = $(this).find('button[type="submit"]')

      submit_button.prop('disabled', true);

      textarea.on("keyup", function () {

        if (textarea.val() == '') {
          submit_button.prop('disabled', true);
        } else {
          submit_button.prop('disabled', false);
        }
      })
    }
  })
})
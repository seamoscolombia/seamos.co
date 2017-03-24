
$( document ).on('turbolinks:load', function() {
  function csvField() {
    if (pollPrivateTrue.checked) {
      $('#csv-field').show();
    } else {
      $('#csv-field').hide();
    }
  }
  var pollPrivateTrue = document.getElementById('poll_private_true');
  var pollPrivateFalse = document.getElementById('poll_private_false');
  if (pollPrivateTrue && pollPrivateFalse) {
    pollPrivateTrue.addEventListener('click', csvField, false);
    pollPrivateFalse.addEventListener('click', csvField, false);
  }
});

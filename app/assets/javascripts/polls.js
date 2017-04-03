
$(document).on('turbolinks:load', function() {

  function csvField() {
    if (pollPrivateTrue.checked) {
      $('#csv-field').show();
    } else {
      $('#csv-field').hide();
    }
  }
  function charLeft (){
    counterLabel.text(500 - (this.value.length));
  }
  var textArea = $('#poll-description');
  var counterLabel = $('#counter-label');
  var pollPrivateTrue = document.getElementById('poll_private_true');
  var pollPrivateFalse = document.getElementById('poll_private_false');

  if (pollPrivateTrue && pollPrivateFalse) {
    pollPrivateTrue.addEventListener('click', csvField, false);
    pollPrivateFalse.addEventListener('click', csvField, false);
    counterLabel.text(500 - (textArea.val().length));
    textArea.on('keydown', charLeft);
  }
});

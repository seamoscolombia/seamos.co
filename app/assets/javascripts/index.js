$( document ).on('turbolinks:load', function() {
  $(".button-sender").click(formConfig);
  $("#polls_filter").change(filterPoll);
});

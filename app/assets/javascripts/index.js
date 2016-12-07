$( document ).on('turbolinks:load', function() {
  var pF = $("#polls_filter");
  var bS = $(".button-sender");
  var bVTA = $("#button_vote_types_attributes");
  loginScreen();
  if(pF.length > 0){
    pF.change(filterPoll);
  }
  // .button-sender only renders in partial _poll.html.erb
  if(bS.length > 0){
    bS.click(formConfig);
  }
  if(bVTA.length > 0){
    bVTA.click(addOption);
  }
});

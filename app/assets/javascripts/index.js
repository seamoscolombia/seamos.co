$( document ).on('turbolinks:load', function() {
  var fU = $("#usuarios_filter");
  var bS = $(".button-sender");
  var bVTA = $("#button_vote_types_attributes");
  var bDebate = $("#button_questions_attributes");
  loginScreen();
  if(fU.length > 0){
    fU.change(filterUser);
  }
  // .button-sender only renders in partial _poll.html.erb
  if(bS.length > 0){
    bS.click(formConfig);
  }
  if(bVTA.length > 0){
    bVTA.click(addOption);
  }
  if(bDebate.length > 0){
    bDebate.click(addOptionQuestion);
  }
});

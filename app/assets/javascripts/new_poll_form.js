$( document ).ready(function(){
  if ($("#control-radio").prop("checked") == true) {
    $("#vote-agreement-select").attr("disabled", "disabled");
  }
  if ($("#agreement-radio").prop("checked") == true) {
    $("#politic-control-select").attr("disabled", "disabled");
  }
  $("#control-radio").click(function(){
    $(".politic-control").show()
    $(".vote-or-agreement").hide()
    if ($("#control-radio").prop("checked") == true) {
      $("#vote-agreement-select").attr("disabled", "disabled");
      $("#politic-control-select").attr("disabled", false);
    }
  })
  $("#agreement-radio").click(function(){
    $(".politic-control").hide()
    $(".vote-or-agreement").show()
    if ($("#agreement-radio").prop("checked") == true) {
      $("#politic-control-select").attr("disabled", "disabled");
      $("#vote-agreement-select").attr("disabled", false);
    }
  })
});

$( document ).ready(function(){
  if ($("#poll_poll_type_control_poltico").prop("checked") == true) {
    $(".vote-or-agreement").addClass("hidden");
    $("#vote-agreement-select").attr("disabled", "disabled");
  }
  if ($("#poll_poll_type_voto_o_proyecto_de_acuerdo").prop("checked") == true) {
    $(".vote-or-agreement").removeClass("hidden");
    $(".politic-control").addClass("hidden");
    $("#poll_state").attr("disabled", "disabled");
  }
  $("#poll_poll_type_control_poltico").click(function(){
    $(".politic-control").removeClass("hidden");
    $("#poll_state").removeAttr("disabled");
    $(".vote-or-agreement").addClass("hidden");
    $("#vote-agreement-select").attr("disabled", "disabled");
  })
  $("#poll_poll_type_voto_o_proyecto_de_acuerdo").click(function(){
    $(".vote-or-agreement").removeClass("hidden");
    $("#vote-agreement-select").removeAttr("disabled");
    $(".politic-control").addClass("hidden");
    $("#poll_state").attr("disabled", "disabled");
  })
});

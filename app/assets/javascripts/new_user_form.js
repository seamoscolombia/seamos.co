// $("#user_role_type_administrador")
$( document ).on('turbolinks:load', function() {
  $("#user_role_type_politico").click(function(){
    console.log("shazzzaam!");
    $(".politician-field").fadeIn("slow")
  })
  $("#user_role_type_administrador").click(function(){
    console.log("shazzzaam!");
    $(".politician-field").fadeOut("slow")
  })
}
)

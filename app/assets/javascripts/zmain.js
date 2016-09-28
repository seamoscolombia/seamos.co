function normalEvent(event){
  return true
}
function formConfig (event) {
        event.preventDefault();
        var myBtn = $(this);
        var myForm = $(this).parent();
        swal({
            title: "¿Deseas publicar?",
            text: "Invita a tus amigos a que participen en esta propuesta.",
            type: "info",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Compartir",
            cancelButtonText: "No, gracias",
            closeOnConfirm: false
        }, function(isConfirm){
            if (isConfirm) {
                myForm.children("#vote_fb_feed").val("true")
                swal("¡Gracias!", "Has invitado a tus amigos a participar", "success");
            }
            myForm.trigger('submit');
        });
};



$( document ).on('turbolinks:load', function() {
  $(".button-sender").click(formConfig);
});

function formConfig (event) {
        event.preventDefault();
        swal({
            title: "¿Deseas publicar?",
            text: "Invita a tus amigos a que participen en esta propuesta.",
            type: "info",
            showCancelButton: true,
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "Compartir",
            cancelButtonText: "No, gracias",
            closeOnConfirm: false,
            closeOnCancel: false
        }, function(isConfirm){
            var myForm = $(this);
            if (isConfirm) {
                myForm.children("#vote_fb_feed").val("true")
                swal("¡Gracias!", "Has invitado a tus amigos a participar", "success");
            }

            var dataString = myForm.serialize();
            myForm.submit();
        });
};

$( document ).on('turbolinks:load', function() {
  $(".form-sender").submit(formConfig);
});

var ready = function() {
   if ($("#links-field").val() == null){
     var linklist = []
   } else {
     var linklist = $("#links-field").val().split(',')
   }
    $(".extlink").blur(function(){
        var linkname = $(this).val()
        console.log(linkname);
        linklist.push(linkname);
        $("#links-field").val(`${$('#link-1').val()} , ${$('#link-2').val()}, ${$('#link-3').val()}`);
        return false
    }
  );
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);

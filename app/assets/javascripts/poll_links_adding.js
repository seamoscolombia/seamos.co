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
        $("#links-field").val($('#link-1').val().concat(', ', $('#link-2').val(), ', ', $('#link-3').val()));
        return false
    }
  );
  // var locatinhash = window.location.hash
  // console.log(locatinhash.split('/')[1] == 'poll');
  // if (locatinhash.split('/')[1] == 'poll' && locatinhash.length == 3) {
  //   $('.poll-info').on("click", window.setTimeout(function() {
  //     console.log('work');
  //     window.location.reload();
  //   }, 50));
  // }
};

$(document).ready(ready);
$(document).on('turbolinks:load', ready);

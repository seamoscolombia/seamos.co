$( document ).ready(function(){
  if (window.location.pathname.split('/')[1] == "users") {
    $(".tag-component").click(function(event) {
      event.preventDefault()
      var tag_id = $(this).attr('id')
      var user_id = $(this).attr('user_id')
      $.post("/users/"+ user_id +"/interests", {
          tag_id: tag_id
        },
        function (data, status) {
          if (data.status == 'created') {
            $("#" + data.interest.tag_id).find('.tag-selected').removeClass('hidden')
          } else if (data.status == 'deleted') {
            $("#" + data.interest.tag_id).find('.tag-selected').addClass('hidden')
          }
        });
    })
  }
})
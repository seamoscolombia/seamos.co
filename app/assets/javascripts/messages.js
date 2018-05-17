$( document ).ready(function(){
  $('#message-preview').click(function(event){
    event.preventDefault()
    var subject = $('#message_subject').val()
    var content = $('#message_content').val()
    $('form').append("<a href='/mail_preview?subject=" + subject + '&content=' + content + "' target='_blank'> Previsualizar </a>")
  })
})
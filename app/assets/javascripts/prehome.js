ready = function(){
  $('#btn-1').click(function(){
    $('.info').hide('fast');
    $('#info-1').show('fast')
  })
  $('#btn-2').click(function(){
    $('.info').hide('fast');
    $('#info-2').show('fast')
  })
  $('#btn-3').click(function(){
    $('.info').hide('fast');
    $('#info-3').show('fast')
  })
  $('#btn-4').click(function(){
    $('.info').hide('fast');
    $('#info-4').show('fast')
  })
  $('#brand-logo').click(function(event){
    event.preventDefault()
    window.location.href = '/';
  })
  $("#this").click(function() {
    window.location.href = '/?sd=1'
  });

  if (window.location.search.substr(1) == 'sd=1'){
    $('html, body').animate({
      scrollTop: $("#who-are-we").offset().top - 70
    }, 1000);
  };
}

$( document ).on('turbolinks:load', function(){
  ready()
 })
$( document ).ready(function(){ 
  ready()
})

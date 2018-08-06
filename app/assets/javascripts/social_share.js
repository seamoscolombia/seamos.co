ready = function(){
  $('#fb-btn').click(function(){
    $('.ssb-facebook').click()
  })
  $('#tw-btn').click(function(){
    $('.ssb-twitter').click()
  })
}

$( document ).on('turbolinks:load', function(){
  ready()
 })
$( document ).ready(function(){
  ready()
})
$( document ).ready(function(){
  $('#hamburger').unbind().click(function(){
    $("#side-nav").toggleClass('open');
    $("#hide-side-nav").toggleClass('hsn-open');
    $(".carousel-indicators").toggle()
  })
  $('#hide-side-nav').unbind().click(function(){
    $("#side-nav").toggleClass('open');
    $(this).toggleClass('hsn-open');
  })
})
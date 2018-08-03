$( document ).ready(function(){
  $('#hamburger').unbind().click(function(){
    disableScrolling();
    $("#side-nav").toggleClass('open');
    $("#hide-side-nav").toggleClass('hsn-open');
    $(".carousel-indicators").toggle()
    return (this.tog = !this.tog) ? disableScrolling() : enableScrolling();
  })
  $('#hide-side-nav').unbind().click(function(){
    enableScrolling();
    $('body').unbind('touchmove')
    $("#side-nav").toggleClass('open');
    $(this).toggleClass('hsn-open');
  })

  function disableScrolling(){
    var x=window.scrollX;
    var y=window.scrollY;
    window.onscroll=function(){window.scrollTo(x, y);};
  }

  function enableScrolling(){
    window.onscroll=function(){};
  }

})
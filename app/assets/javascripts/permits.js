$( document ).ready(function(){
  $('input[type=radio].role-radio').change(function(){
    $(this)[0].form.submit();
  });
})
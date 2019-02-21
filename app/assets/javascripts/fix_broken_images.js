$(document).ready(function () {
  window.onload = function () {
    (function () {
      var img = document.getElementsByTagName('img');
      var i = 0,
      l = img.length;
      for (; i < l; i++) {
        console.log(img[i].naturalHeight);

        if (img[i].naturalWidth === 0) {
          console.log('image broken');
          img[i].src = 'https://s3.amazonaws.com/misc-assets-seamos/defaultavatar.jpg';
        }
      }
    })()
  }
})
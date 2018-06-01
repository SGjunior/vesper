// console.log('test');
import ProgressBar from 'progressbar.js'



document.addEventListener("DOMContentLoaded", function(event) {

if (document.querySelector('.banner-main')) {

    // setInterval(function(){


      document.getElementById('container-lols').removeAttribute('hidden');
      // var ProgressBar = require('progressbar');

      var bar = new ProgressBar.Path('#heart-path', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar.set(0);
      bar.animate(1);  // Number from 0.0 to 1.0

      var bar2 = new ProgressBar.Path('#heart-path2', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar2.set(0);
      bar2.animate(1);  // Number from 0.0 to 1.0


      var bar3 = new ProgressBar.Path('#hearth-path0', {
        easing: 'easeInOut',
        duration: 2000
      });

      bar3.set(0);
      bar3.animate(1);  // Number from 0.0 to 1.0

    // }, 2000);
  }
});

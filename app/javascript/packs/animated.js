console.log('test');
import ProgressBar from 'progressbar.js'

document.addEventListener("DOMContentLoaded", function(event) {
  // setTimeout(2000);

  setInterval(function(){
    console.log('test');

    // var ProgressBar = require('progressbar');

    var bar = new ProgressBar.Path('#heart-path', {
      easing: 'easeInOut',
      duration: 1400
    });

    bar.set(0);
    bar.animate(1.0);  // Number from 0.0 to 1.0

    var bar2 = new ProgressBar.Path('#heart-path2', {
      easing: 'easeInOut',
      duration: 1400
    });

    bar2.set(0);
    bar2.animate(1.0);  // Number from 0.0 to 1.0
  }, 2000);
});

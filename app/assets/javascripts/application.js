//= require_tree .
//= require jquery
//= require jquery_ujs
//= require jquery.slick

$(document).ready(function(){
  $('.venue-social-pictures').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
  });
});


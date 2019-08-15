$(document).on('turbolinks:load', function() {
  $('.top-slider').slick({
    autoplay: true,
    Speed: 3000,
    dots: true,
    pauseOnDotsHover: true,
    infinite: true,
    arrows: true,
  });
});
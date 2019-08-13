$(document).on('turbolinks:load', function() {
  $('.top-slider').slick({
    autoplay: true,
    Speed: 3000,
    dots: true,
    pauseOnDotsHover: true,
    infinite: true,
    arrows: true,
    prevArrow: '<img src="/assets/carousel-prev.png" class="slick-prev">',
    nextArrow: '<img src="/assets/carousel-next.png" class="slick-next">',
  });
});
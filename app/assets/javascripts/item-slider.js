$(document).on('turbolinks:load', function() {
  $('.thumnaul-slider .thumnaul-slider__outer:first-child').addClass('active');
  $('.thumnaul-slider .thumnaul-slider__outer:first-child').css({'opacity':'1','pointer':'default'});

  $('.thumnaul-slider__outer').hover(function(){
    $('.active').css({'opacity':'','pointer':''})
    $('.active').removeClass('active');
    $(this).addClass('active');
    $(this).css({'opacity':'1','pointer':'default'});
  });

  $('.slider').slick({
    autoplay: false,
    Speed: 3000,
    arrows: false,
    dots: false,
    dotsClass: 'thumnaul-slider',
    pauseOnDotsHover: true,
    infinite: true,
  });

  $('.thumnaul-slider__outer').on('mouseover', function(e){
    var $currTarget = $(e.currentTarget);
    index = $('.thumnaul-slider__outer').index(this);
    slickObj = $('.slider').slick('getSlick');
    slickObj.slickGoTo(index);
  });
});
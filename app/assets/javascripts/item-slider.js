$(document).on('turbolinks:load', function(){
  var slider = "#slider"
  var thumbnailSlider = "#thumbnail-slider .thumbnail-slider__item"

  $(thumbnailSlider).each(function(){
    var index = $(thumbnailSlider).index(this);
    $(this).attr("data-index",index);
  });

  $(slider).on('init',function(slick){
    var index = $(".slide-item.slick-slide.slick-current").attr("data-slick-index");
    $(thumbnailSlider+'[data-index="'+index+'"]').addClass("thumbnail-current");
   });

  $(slider).slick({
    dots: true,
    autoplay: false,
    arrows: false
  });

  $(thumbnailSlider).on('mouseover',function(){
    var index = $(this).attr("data-index");
    $(slider).slick("slickGoTo",index,false);
  });

  $(slider).on('beforeChange',function(event,slick, currentSlide,nextSlide){
    $(thumbnailSlider).each(function(){
      $(this).removeClass("thumbnail-current");
    });
    $(thumbnailSlider+'[data-index="'+nextSlide+'"]').addClass("thumbnail-current");
  });


  $( '.slider' ).on( 'mouseenter', '.slick-dots > li', function() {
    $( this ).click();
  });
  $( '.slider' ).on( 'mouseover', '.slick-dots > li', function() {
    $( this ).css({
      opacity: "1",
      cursor: "pointer"
    });
  });
  $( '.slider' ).on( 'mouseout', '.slick-dots > li', function() {
    $( this ).css({
      opacity: "",
      cursor: ""
    });
  });
});
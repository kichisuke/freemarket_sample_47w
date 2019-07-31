$(document).on('turbolinks:load', function () {
  var search_price_field = $('.group-price');
  var search_price_select = $('.search-price').children('.select-wrap').children('select');
  var price_range;
  var price_array;

  search_price_select.on('change', function() {
    price_range = $(this).val();
    price_array = price_range.split(/\s|~/);
    search_price_field.children('.min').val(price_array.shift());
    search_price_field.children('.max').val(price_array.pop());
  });
});

$(document).on('turbolinks:load', function() {
  $('#brand_search').on('keyup', function() {
    var input = $('#brand_search').val();
     $.ajax({
       url: '/items/brand_search',
       type: 'GET',
       data: {keyword: input},
       dataType: 'json'
     })
  });
});

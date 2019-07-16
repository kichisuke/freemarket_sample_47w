$(document).on('turbolinks:load', function() {
  function appendBrand(brand) {
    var html = `<li class="brand_search_result__list" data-brand-id="${brand.id}" data-brand-name="${brand.name}">
                  ${brand.name}
                </li>`
    $('.brand_search_result').append(html);
  }
  function appendErrMsg(msg) {
    var html = `<p class="brand_search_result__nothing">${msg}</p>`
    $('.brand_search_result').append(html);
  }
  $('#brand_search').on('keyup', function() {
    var input = $('#brand_search').val();
     $.ajax({
       url: '/items/brand_search',
       type: 'GET',
       data: {keyword: input},
       dataType: 'json'
     })

     .done(function(brands) {
       $('.brand_search_result').empty();
       if (brands.length !== 0) {
         brands.forEach(function(brand) {
           appendBrand(brand);
         })
       }
       else {
        appendErrMsg("一致するブランドがありません");
       }
     })
  });
});

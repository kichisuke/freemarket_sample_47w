$(document).on('turbolinks:load', function() {
  if(document.getElementById("item-price") != null) {
    currentPrice = $('#item-price').val();
    price = currentPrice
    if (price >= 300 && price < 10000000) {
      var commission = price / 10;
      var commissionFloor = Math.floor(commission) ;
      $("#commission").empty();
      $("#commission").append("¥");
      $("#commission").append(commissionFloor.toLocaleString());
      var profit = price - commissionFloor
      $("#profit").empty();
      $("#profit").append("¥");
      $("#profit").append(profit.toLocaleString());
    } else {
      $("#commission").empty();
      $("#commission").append("-");
      $("#profit").empty();
      $("#profit").append("-");
    };
    $('#item-price').on('input', function(e) {
      let price = $(e.currentTarget).val();
      price = price
          .replace(/[０-９]/g, function(s) {
              return String.fromCharCode(s.charCodeAt(0) - 65248);
          })
          .replace(/[^0-9]/g, '');
      $(e.currentTarget).val(price);
      if (price >= 300 && price < 10000000) {
        var commission = price / 10;
        var commissionFloor = Math.floor(commission) ;
        $("#commission").empty();
        $("#commission").append("¥");
        $("#commission").append(commissionFloor.toLocaleString());
        var profit = price - commissionFloor
        $("#profit").empty();
        $("#profit").append("¥");
        $("#profit").append(profit.toLocaleString());
      } else {
        $("#commission").empty();
        $("#commission").append("-");
        $("#profit").empty();
        $("#profit").append("-");
      };
    });
  };
});
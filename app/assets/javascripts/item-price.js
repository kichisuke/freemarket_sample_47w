$(function(){
  if(document.getElementById("item-price") != null) {
    $("#item-price").on("keyup", function(){
      var input = $("#item-price").val();
      if (input >= 300 && input < 10000000) {
        var commission = input / 10;
        var commissionFloor = Math.floor(commission) ;
        $("#commission").empty();
        $("#commission").append("¥");
        $("#commission").append(commissionFloor.toLocaleString());
        var profit = input - commissionFloor
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
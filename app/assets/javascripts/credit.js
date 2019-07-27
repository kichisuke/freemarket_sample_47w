$(document).on('turbolinks:load', function() {
  var form = $("#credit-form");
  Payjp.setPublicKey('pk_test_2cf03f0c1b9560e918e7ce5d');

  $("#credit-form").on("click", "#submit-button", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: parseInt($("#card-number").val()),
        cvc: parseInt($("#cvc").val()),
        exp_month: parseInt($("#card_expire_mm").val()),
        exp_year: parseInt($("#card_expire_yy").val())
    };
    Payjp.createToken(card, function(status, response) {
      if (status == 200) {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

        var token = response.id;
        $("#credit-form").append($('<input type="hidden" name="payjp_token" class="payjp-token" />').val(token));
        $("#credit-form").get(0).submit();
      }
      else {
        alert("error")
        form.find('button').prop('disabled', false);
      }
    });
  });
});
